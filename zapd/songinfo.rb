require 'taglib'

class SongInfo
  attr_accessor :mFile
  attr_accessor :mArtist
  attr_accessor :mTitle
  def initialize(inFile)
    @mFile = inFile
    file = TagLib::File.new(inFile)
    @mArtist = file.artist
    @mTitle = file.title
  end
  
  def toFilePath()
    return "file://"+mFile
  end
  
  def toString()
    return "Artist: " + @mArtist +"\nTitle: " + @mTitle + "\nFilename: " + @mFile + "\n"
  end
end