require_relative '../config/environment.rb'

class Song
  attr_accessor :name, :artist, :genre
  extend Concerns::Findable # calls Findable module for class methods

  @@all = []    # creates empty array
  def initialize(name, artist = nil, genre = nil)  # takes song name and optional aritst and genre name
    @name = name    # assigns song name to instance variable
    self.artist = artist if artist != nil   # links song to artist if artist is given
    self.genre = genre if genre != nil      # links song to genre if genre is given
  end

  def self.all    # getter method for @@all array
    @@all
  end

  def self.destroy_all    # clears @@all array
    @@all.clear 
  end

  def self.create(song)   # creates new instance of song and saves it
    self.new(song).tap {|song| song.save}   # creates song instance w/ name, saves it to @@all and returns it 
  end

  def save    # saves instance of song to @@all array
    self.class.all << self
  end

  def artist=(artist)
    @artist = artist        # assigns input given to instance variable
    @artist.add_song(self)  # adds current song to that artist's song list
  end

  def genre=(genre) # returns the genre's 'songs' collection 
    @genre = genre  # assings input given to instance variable
    self.genre = @genre if self.genre != genre  # makes this song belong to genre if it doesn't already
    @genre.songs << self if !@genre.songs.include?(self)  # puts this song in genre's songs array
  end

  def self.new_from_filename(file_name)
    file_split = file_name.split(/ - |.mp3/) # splits all at - mark
    if self.find_by_name(file_split[1]) == nil  # checks if song exists already
      self.new(file_split[1]).tap do |s|  # if it doesn't, it makes new Song instance  
        s.artist = Artist.find_or_create_by_name(file_split[0]) # finds or creates artist
        s.genre = Genre.find_or_create_by_name(file_split[2])   # and genre
      end
    end
  end

  def self.create_from_filename(file_name) # creates new song instance if not already there, saves to @@all array and returns song instance
    self.new_from_filename(file_name).tap {|song| self.all << song}
  end
end