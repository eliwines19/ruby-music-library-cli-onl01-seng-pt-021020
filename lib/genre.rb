require_relative './concerns/findable.rb'

class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end
  # accepts a name for the new genre
  # creates a 'songs' collection

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
  # adds the Genre instance to the @@all class variable

  def self.create(name)
    g = self.new(name)
    g.save
    g
  end
  #nitializes and saves the genre

  def artists
    @songs.map { |m| m.artist }.uniq
  end
  # returns a collection of artists for all of the genres songs
  # does not returnaduplicate artists if the genre has more than one song by a particular artist
  # collects artists through its songs instead of maintaining its own @artsts instance variable 

end
