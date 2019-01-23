class Track < Model
  attr_accessor :name, :artist_id, :descript

  def initialize args={}
    self.name = args[:name]
    self.artist_id = args[:artist_id] || "unknown"
    self.descript = args[:descript]
  end

  def self.adaptor
    @adaptor ||= $adaptor.new "tracks"
  end

  def artist
    Artist.find self.artist_id
  end
end
