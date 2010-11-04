require 'gst'

class Backend
  attr_accessor :player
  def initialize
    @player = Gst::ElementFactory.make("playbin2")
    @mDebug = true;
  end
  
  def playFile(inFile)
    if(@mDebug)
      p "Play File " + inFile
    end
    @player.uri = inFile
    play
  end
  
  def play
    if(@mDebug)
      p "Play"
    end
    @player.play
  end
  
  def pause
    if(@mDebug)
      p "Pause"
    end
    @player.pause
  end
  
  def stop
    if(@mDebug)
      p "Stop"
    end
    @player.stop
    @loop.quit
  end
  
  def mainLoop(callback)
    # create the program's main loop
    @loop = GLib::MainLoop.new(nil, false)

    # listen to playback events
    bus = @player.bus
    bus.add_watch do |bus, message|
      case message.type
      when Gst::Message::EOS
        callback.call()
        #@loop.quit
      when Gst::Message::ERROR
        p message.parse
        callback.call()
        #@loop.quit 
      end
      true
    end
    play
    @loop.run    
  end
  
  def getState
    return @player.get_state
  end
end