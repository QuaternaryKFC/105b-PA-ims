class YamlAdaptor

  def initialize klass
    @store = YAML::Store.new $storage+klass+'.yml'
  end

  def store
    @store
  end

  def entries
    @entries ||= store.transaction{ store[:entries] }
    @entries ||= {}
  end

  def insert obj
    id = obj.id
    if entries[id]
      return false
    end
    entries[id] = obj
    store.transaction{ store[:entries]=entries }
    true
  end

  def delete obj
    id = obj.id
    if entries[id].nil?
      return false
    end
    entries.delete id
    store.transaction{ store[:entries]=entries }
    true
  end

  def update obj
    id = obj.id
    if entries[id].nil?
      return false
    end
    entries[id] = obj
    store.transaction{ store[:entries]=entries }
    true
  end

  def all
    entries.values
  end

  def find id
    entries[id]
  end

  def where cons
    entries.select do |id, obj|
      sat = true
      cons.each do |k, v|
        sat = false if obj.send(k)!=v
        break if !sat
      end
      sat
    end.values
  end

  def default_id
    id = store.transaction{ store[:default_id] }
    if id.nil?
      id=0
    else
      id+=1
    end
    store.transaction{ store[:default_id]=id }
  end
end
