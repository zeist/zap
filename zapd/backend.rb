require 'gst'

class Backend
  attr_accessor :player
  def initialize
    @player = Gst::ElementFactory.make("playbin2")
  end
  
  def playFile(inFile)
    @player.uri = inFile
    play
  end
  
  def play
    @player.play
  end
  
  def pause
    @player.pause
  end
  
  def stop
    p "Shutting down"
    @player.stop
    @loop.quit
  end
  
  def mainLoop  
    # create the program's main loop
    @loop = GLib::MainLoop.new(nil, false)

    # listen to playback events
    bus = @player.bus
    bus.add_watch do |bus, message|
      case message.type
      when Gst::Message::EOS
        @loop.quit
      when Gst::Message::ERROR
        p message.parse
        @loop.quit
      end
      true
    end
    play
    @loop.run    
  end
end