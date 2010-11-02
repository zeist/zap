#!/usr/bin/env ruby
require 'socket'

class NetServer < TCPServer
  def Initialize()
  end

  def start_server(callback)
    loop do
        Thread.start(self.accept) do |s|
        p "Connection accepted from server #{s.inspect}"
        request = s.readline.gsub(/\n$/, '')
        p "Request was #{request}"
        response = "OK"
        s.write(response)
        s.close
        callback.call(request)
      end
   end
  end
end