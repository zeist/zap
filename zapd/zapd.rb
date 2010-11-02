#!/usr/bin/env ruby
require 'serversocket'
require 'player'

@player = Player.new

def callbackMethod(inRequest)
  @player.play(inRequest)
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
