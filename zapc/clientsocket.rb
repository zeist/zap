#!/usr/bin/env ruby
require 'socket'

class ClientSocket
  def initialize()
  end
  def send_message(message)
    TCPSocket.open('127.0.0.1', 3000) do |client|
      client.write(message)
      stuff =  client.read(10000)
      client.close
  	  return stuff
    end
  end
  
  def sendCommand(inParams)
	message = inParams.join("#")
    message += "\n"
	  return send_message(message)       
  end
end 
