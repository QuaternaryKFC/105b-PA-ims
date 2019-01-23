class Model
  attr_reader :id

  def adaptor
    self.class.adaptor
  end

  def self.adaptor
  end

  def save
    if id.nil?
      @id = adaptor.default_id
    end
    adaptor.insert self
  end

  def destroy
    adaptor.delete self
  end

  def update
    adaptor.update self
  end

  def self.all
    adaptor.all
  end

  def self.find id
    adaptor.find id.to_i
  end

  def self.where cons={}
    adaptor.where cons
  end
end
