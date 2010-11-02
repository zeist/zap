#!/usr/bin/env/ruby

load File.dirname(__FILE__)+"/backend.rb"
  
class Player
  
  def initialize
    @backend = Backend.new
  end
  
  def play(inFile)
    if(inFile!="")
      @backend.playFile(inFile)
    else
      @backend.play
    end  
    @backend.mainLoop()
  end  
  def stop
    @backend.stop
  end
end
