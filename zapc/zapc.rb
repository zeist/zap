#!/usr/bin/env ruby
load File.dirname(__FILE__)+"/clientsocket.rb"

socket = ClientSocket.new
response = socket.sendCommand(ARGV).split("\n")

response.each{ |line| p line}
