
class LastFM
  def initialize
    @mScrobbled = false
  end
  def songChanged(inSong)
    @mCurrentSong = inSong
    @mScrobbled = false
  end
  
  def update(inTime)
    if(inTime<0 || @mCurrentSong.nil?)
      return;
    end
    if(inTime > @mCurrentSong.mLength*500 && @mScrobbled == false)
      p "Scrobbling hook goes here"
      @mScrobbled = true;
    end
  end
end