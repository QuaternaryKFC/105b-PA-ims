class Interpreter

  def initialize
    @cmds = { "help" => :help,
              "info" => :info,
              "add" => :add,
              "count" => :count,
              "list" => :list,
              "play" => :play }
  end

  def execute cmd
    return nil if cmd=="exit"
    args = cmd.split(/\s+/)
    cmd = args.shift
    if !@cmds.include? cmd
      return "Can't find command\n"+help
    end
    self.send @cmds[cmd], *args
  end

  def help *args
    return File.read $help
  end

  def info *args
    if args.empty?
      output =
      "Total tracks: #{Track.all.count};\n" +
      "Total artists: #{Artist.all.count};\n" +
      "Last 10 tracks played\n" +
      PlayRecord.all
      .sort_by{|r| r.time_played}.last(10)
      .map{|r|
        "id: #{r.track_id}; name: #{r.track.name}" unless r.nil?
      }.join("\n")
    else
      case args[0]
      when "track"
        track = Track.find args[1]
        return "Can't find the track" if track.nil?
        output =
        "id: #{track.id};\n" +
        "name: #{track.name};\n" +
        "artist: #{track.artist.nil? ? "unknown" : track.artist.name};\n" +
        "description: #{track.descript};"
      when "artist"
        artist = Artist.find args[1]
        return "Can't find the artist" if artist.nil?
        output =
        "id: #{artist.id};\n" +
        "name: #{artist.name};\n" +
        "description: #{artist.descript};"
      else
        output = "Incorrect arguments"
      end
    end
    return output
  end

  def add *args
    case args[0]
    when "track"
      by = args.find_index "by"
      if by.nil?
        track = Track.new name: args[1..-1].join(" ")
      else
        artist = Artist.find args[by+1]
        return "Can't find the artist" if artist.nil?
        track = Track.new name: args[1...by].join(" "),
                          artist_id: artist.id
      end
      track.save
      output =
      "id: #{track.id};\n" +
      "name: #{track.name};"
    when "artist"
      artist = Artist.new name: args[1..-1].join(" ")
      artist.save
      output =
      "id: #{artist.id};\n" +
      "name: #{artist.name};"
    else
      output = "Incorrect arguments"
    end
  end

  def count *args
    case args[0..1].join(" ")
    when "tracks by"
      artist = Artist.find args[2]
      if artist.nil?
        output = "Can't find the artist"
      else
        output =
        "#{artist.name} has #{artist.tracks.count} tracks;"
      end
    else
      output = "Incorrect arguments"
    end
  end

  def list *args
    case args[0..1].join(" ")
    when "tracks by"
      artist = Artist.find args[2]
      if artist.nil?
        output = "Can't find the artist"
      else
        output = artist.tracks.map{ |t|
          "id: #{t.id}; name: #{t.name}"
        }.join("\n")
      end
    else
      output = "Incorrect arguments"
    end
  end

  def play *args
    case args[0]
    when "track"
      track = Track.find args[1]
      if track.nil?
        output = "Can't find the track"
      else
        record = PlayRecord.new track_id: track.id, time_played: DateTime.now
        record.save
        output =
        "Played track:\n" +
        "id: #{track.id}; name: #{track.name};"
      end
    else
      output = "Incorrect arguments"
    end
  end
end
