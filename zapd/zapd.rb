#!/usr/bin/env ruby
load File.dirname(__FILE__)+"/serversocket.rb"
load File.dirname(__FILE__)+"/player.rb"

@player = Player.new

def callbackMethod(inRequest)
      requestParams = inRequest.split("#")
      if(requestParams.size > 0)
            if(requestParams[0] == "play")
                  if(requestParams.size>1)
                    @player.play(requestParams[1])
                  else
                    p "resume"
                    @player.play("")
                  end
                  return "Playing " + requestParams[1]
            elsif(requestParams[0] == "stop")
                  @player.stop
                  return "Stopped"
            elsif(requestParams[0] == "add")
                  @player.addSongToPlaylist(requestParams[1])
                  return "Added " + requestParams[1]
            elsif(requestParams[0] == "info")
                  return @player.getCurrentSong().toString()
            elsif(requestParams[0] == "pause")
                  @player.pause
                  return "paused"
            end
      end
end

server = NetServer.new('0.0.0.0',3000)
server.start_server(method(:callbackMethod))

loop do
  begin
  rescue Interrupt
  ensure
    @player.stop
  end
end
