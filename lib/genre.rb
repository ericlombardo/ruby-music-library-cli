require_relative '../config/environment.rb'

class Genre
  attr_accessor :name, :songs
  extend Concerns::Findable # calls Findable module for class methods
  
  @@all = []    # creates empty array
  def initialize(name)
    @name = name    # assigns genre name to instance variable
    @songs = []
  end

  def self.all   # getter method for @@all array 
    @@all
  end

  def self.destroy_all    # clears @@all array
    @@all.clear
  end
  
  def self.create(genre)    # creates new instance of genre and saves it
    self.new(genre).tap {|g| g.save}  # creates genre instance w/ name, saves it to @@all and returns it 
  end

  def save  # saves instance of genre to @@all array
    self.class.all << self
  end

  def artists #=> artist instances linked to this genre
    self.songs.collect {|s| s.artist}.uniq  # loops through songs array to collect `uniq` artist instances
  end

end