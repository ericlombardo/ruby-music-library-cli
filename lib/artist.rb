require_relative '../config/environment.rb'

class Artist
  attr_accessor :name, :songs
  extend Concerns::Findable # calls Findable module for class methods

  @@all = []  # creates empty arrays
  def initialize(name)
    @name = name  # assigns artist name to instance variable
    @songs = []
  end

  def self.all  # getter method for @@all array
    @@all
  end

  def self.destroy_all  # clears @@all array
    @@all.clear
  end

  def self.create(artist) # creates new instance of artist and saves it
    self.new(artist).tap {|a| a.save} # creates artist instance w/ name, saves it to @@all and returns it 
  end

  def save  # saves instance of artist to @@all array
    self.class.all << self
  end

  def add_song(song_name)   # takes in song
    song_name.artist = self if song_name.artist == nil  # links artist to song if not already assigned
    self.songs << song_name if !self.songs.include?(song_name)  # adds song to artist's song array if not there already
  end

  def genres  #=> genre instances linked to this artist 
    self.songs.collect {|s| s.genre}.uniq  
  end
end