require 'minitest/autorun'

require_relative '../../dependencies'
require_relative '../../models/_model'
require_relative '../../models/artist'
require_relative '../../models/track'
require_relative '../../models/play_record'

describe "models test" do
  before do

  end

  it "artist has name and descript" do
    name = "a"
    descript = "b"
    @a = Artist.new name: name, descript: descript
    @a.name.must_equal name
    @a.descript.must_equal descript
  end

  it "track has name, descript and artist_id" do
    name = "a"
    descript = "b"
    artist_id = "c"
    @a = Track.new name: name, descript: descript, artist_id: artist_id
    @a.name.must_equal name
    @a.descript.must_equal descript
    @a.artist_id.must_equal artist_id
  end

  it "play_record has track_id and time_played" do
    track_id = "a"
    time_played = DateTime.now
    @a = PlayRecord.new track_id: track_id, time_played: time_played
    @a.track_id.must_equal track_id
    @a.time_played.must_equal time_played
  end
end
