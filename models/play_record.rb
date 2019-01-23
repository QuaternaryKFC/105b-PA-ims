class PlayRecord < Model
  attr_accessor :track_id, :time_played

  def initialize args={}
    self.track_id = args[:track_id]
    self.time_played = args[:time_played]
  end

  def self.adaptor
    @adaptor ||= $adaptor.new "play_records"
  end

  def track
    Track.find self.track_id
  end
end
