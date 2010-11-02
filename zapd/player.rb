#!/usr/bin/env/ruby

load File.dirname(__FILE__)+"/backend.rb"
load File.dirname(__FILE__)+"/playlist.rb"
  
class Player
  
  def initialize
    @backend = Backend.new
    @mPlaylist = Playlist.new
  end
  
  def play(inFile)
    if(inFile!="")
      @backend.playFile(inFile)
    else
      @backend.play
    end  
    @backend.mainLoop(method(:completed))
  end  
  
  def stop
    @backend.stop
  end
  
  def addSongToPlaylist(inFile)
    @mPlaylist.enqueue(inFile);
  end
  
  def completed
    stop
    play(@mPlaylist.dequeue());
  end
end
