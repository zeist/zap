#!/usr/bin/env ruby
load File.dirname(__FILE__)+"/clientsocket.rb"

socket = ClientSocket.new
socket.sendCommand(ARGV)
