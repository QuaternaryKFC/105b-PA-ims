class Artist < Model
  attr_accessor :name, :descript

  def initialize args={}
    self.name = args[:name]
    self.descript = args[:descript]
  end

  def self.adaptor
    @adaptor ||= $adaptor.new "artists"
  end

  def save
    count = 0
    @id = name.split(/\s+/).map{|n| n[0]}.join + count.to_s
    while self.class.find @id
      count+=1
      @id = @id[0...-1]+count.to_s
    end
    super
  end

  def self.find id
    adaptor.find id.to_s
  end

  def tracks
    Track.where artist_id: self.id
  end
end
