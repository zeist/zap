require 'taglib'

class SongInfo
  attr_accessor :mFile
  attr_accessor :mArtist
  attr_accessor :mTitle
  attr_accessor :mLength
  def initialize(inFile)
    @mFile = inFile
    file = TagLib::File.new(inFile)
    @mArtist = file.artist
    @mTitle = file.title
    @mLength = file.length
  end
  
  def toFilePath()
    return "file://"+mFile
  end
  
  def toString()
    return "Artist: " + @mArtist +"\nTitle: " + @mTitle + "\nLength: " + @mLength.to_s + "\nFilename: " + @mFile + "\n"
  end
end