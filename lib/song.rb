class Song

  attr_accessor :name, :artist, :genre
  @@all = []
  #initilized as an empty array 

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  # accepts a name for the new song 

  def self.all
    @@all
  end
  # returns the all class variable 

  def self.destroy_all
    @@all = []
  end
  # resets the all class variable 

  def save
    @@all << self
  end
  # adds the Song instance to the @@all class variable 

  def self.create(name)
    s = self.new(name)
    s.save
    s
  end
  # initializes, saves, and returns the song 

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    if !@genre.songs.include?(self)
      @genre.songs << self
    end
  end

   def self.find_by_name(name)
     @@all.find { |s| s.name == name }
   end

   def self.find_or_create_by_name(name)
     self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end

  def self.new_from_filename(file)
    name = file.gsub(".mp3","").split(" - ")
    song_name = name[1]
    artist_name = Artist.find_or_create_by_name(name[0])
    genre_name = Genre.find_or_create_by_name(name[2])
    self.new(song_name, artist_name, genre_name)
  end

  def self.create_from_filename(file)
    @@all << self.new_from_filename(file)
  end

end
