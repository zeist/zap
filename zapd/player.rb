#!/usr/bin/env/ruby

load File.dirname(__FILE__)+"/backend.rb"
load File.dirname(__FILE__)+"/playlist.rb"
load File.dirname(__FILE__)+"/songinfo.rb"
require 'taglib'
  
class Player
  
  def initialize
    @backend = Backend.new
    @mPlaylist = Playlist.new
  end
  
  def play(inFile)
    @mCurrentSong = SongInfo.new(inFile)
    if(inFile!="")
      @backend.playFile(@mCurrentSong.toFilePath())
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
    nextSong = @mPlaylist.dequeue();
    p nextSong
    if(!nextSong.nil?)
      play(nextSong)
    end
  end
  def getCurrentSong
    return @mCurrentSong
  end
  
end
