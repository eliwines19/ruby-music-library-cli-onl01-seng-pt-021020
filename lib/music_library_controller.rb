class MusicLibraryController

  def initialize(path = './db/mp3s')
    @path = path
    mi = MusicImporter.new(path)
    mi.import
  end
  
end
