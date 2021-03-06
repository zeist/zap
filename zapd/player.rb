#!/usr/bin/env/ruby

load File.dirname(__FILE__)+"/backend.rb"
load File.dirname(__FILE__)+"/playlist.rb"
load File.dirname(__FILE__)+"/songinfo.rb"
load File.dirname(__FILE__)+"/lastfm.rb"
require 'taglib'
  
class Player
  
  def initialize
    @backend = Backend.new
    @mPlaylist = Playlist.new
    @mScrobbler = LastFM.new
    @backendThread = nil
    Thread.new do
      loop do
        @mScrobbler.update(@backend.getTime)        
      end
    end
  end
  
  def play(inFile)
    if(inFile!="")
      @mCurrentSong = SongInfo.new(inFile)
      Thread.new do
        p "New Thread"
        @mScrobbler.songChanged(@mCurrentSong)
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
  def getState
    return @backend.getState.to_s
  end
  
  def getTime
    @backend.getTime  
  end
  
end
