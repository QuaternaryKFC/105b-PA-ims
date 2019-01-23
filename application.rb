class Application

  def initialize
    @interpreter = $interpreter.new
  end

  def run
    loop do
      print "ims> "
      cmd = $stdin.gets.strip.downcase
      output = @interpreter.execute cmd
      break if output.nil?
      puts "=> " + output
    end
  end
end
