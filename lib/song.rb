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
  # can be invoked with an optional second argument, and Artist objects to be assigned to the songs 'artist' property

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
  # assigns an artist to the song

  def genre=(genre)
    @genre = genre
    if !@genre.songs.include?(self)
      @genre.songs << self
    end
  end
  # assigns a genre to the songs, adds the song to the genres collection of songs
  # does not add the song to the genres collection of songs if it already exists

   def self.find_by_name(name)
     @@all.find { |s| s.name == name }
   end
   # finds a song instances in @@all by the name property of the song

   def self.find_or_create_by_name(name)
     self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end
  # returns an existing song with the provided name if one exists in @@all
  # invokes .find_by_name instead of re-coding the same functionality
  # creates a song if an existing mathc is not found
  # invokes .create instead of re-coding the same functionality

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
