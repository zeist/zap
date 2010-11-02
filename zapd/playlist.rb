class Playlist
  def initialize
    @mSongList = Array.new
  end
  
  def getFirst()
    return @mSongList.first
  end
  
  def dequeue()
    outSong = getFirst()
    p outSong
    if(!outSong.nil?)
      @mSongList.delete_at(0)
    end
    return outSong
  end
  
  def enqueue(inSong)
    @mSongList << inSong
  end
end