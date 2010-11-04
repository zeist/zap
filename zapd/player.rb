#!/usr/bin/env/ruby

load File.dirname(__FILE__)+"/backend.rb"
load File.dirname(__FILE__)+"/playlist.rb"
load File.dirname(__FILE__)+"/songinfo.rb"
require 'taglib'
  
class Player
  
  def initialize
    @backend = Backend.new
    @mPlaylist = Playlist.new
    @backendThread = nil
  end
  
  def play(inFile)
    if(inFile!="")
      @mCurrentSong = SongInfo.new(inFile)
      Thread.new do
        p "New Thread"
        @backend.playFile(@mCurrentSong.toFilePath())
        @backend.mainLoop(method(:completed))      
      end
    else
        p "resuming"
        @backend.play
    end
  end  
  
  def stop
    @backend.stop
  end
  
  def addSongToPlaylist(inFile)
    @mPlaylist.enqueue(inFile);
  end
  
  def pause
    @backend.pause
  end
  
  def completed
    stop
    nextSong = @mPlaylist.dequeue();
    if(!nextSong.nil?)
      play(nextSong)
    end
  end
  def getCurrentSong
    return @mCurrentSong
  end
  
end
