require_relative './concerns/findable.rb'

class Artist
  extend Concerns::Findable 

  attr_accessor :name, :genres
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end
  # accepts a name for the new artist 
  # creates a 'songs' property set to an empty array

  def self.all
    @@all
  end
  # returns the @@all class variable 

  def self.destroy_all
    @@all = []
  end
  # clears the @@all class variable

  def save
    @@all << self
  end
  # adds the Artist instances to the @@all class variable 

  def self.create(name)
    a = self.new(name)
    a.save
    a
  end
  #initializes and saves the artist 

  def add_song(song)
    if !@songs.include?(song)
      @songs << song
      song.artist = self if song.artist.nil?
    end
  end
  # assigns the current artist to the songs 'artist' property 
  # does not assign the artist if the song already has an artist 
  # adds the song to the current artists 'songs' collection 

  def songs
    @songs
  end
  # returns the artists 'songs' collection 

  def genres
    @songs.map { |m| m.genre }.uniq
  end
  # returns a collection of genres for all of the artists songs 
  # does not return duplicate genres if the arttist has more that on esong of a particular genre 
  # collects genres through its songs instead of maintaining its own @genres instance variable 

end
