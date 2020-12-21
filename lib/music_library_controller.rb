require_relative '../config/environment.rb'


class MusicLibraryController 
  attr_accessor :path 
  extend Concerns::Findable


  def initialize(path = './db/mp3s')  # creates new MusicImporter instance
    MusicImporter.new(path).import    # and imports files from designated path
  end

  def call # greets user and executes commands
    user_input = nil
    until user_input == 'exit'
      display_prompt
      user_input = gets.strip
      cli_commands(user_input)
    end
  end

  def display_prompt  # shows options
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
  end

  def list_songs # sorts songs by name, then outputs numbered list with artist, song, and genre
    Song.all.sort_by{|s| s.name}.each_with_index do |s, i|
      puts "#{i + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists # sorts artist's by name, then outputs numbered list 
    Artist.all.sort_by{|a| a.name}.each_with_index do |a, i| 
      puts "#{i+1}. #{a.name}"
    end
  end

  def list_genres
    Genre.all.sort_by{|g| g.name}.each_with_index do |g, i| # sorts genres
      puts "#{i+1}. #{g.name}"  # puts out formatted genres
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"  # asks for artist
    search_for = gets.strip # takes input in
    songs = Song.all.select{|s| s.artist.name == search_for} # collects all songs for artist
    songs.sort_by{|s| s.name}.each_with_index do |s, i| # sorts songs by name
      puts "#{i+1}. #{s.name} - #{s.genre.name}" # puts formatted song name and genre out for each song
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"  # asks for genre
    search_for = gets.strip # takes input in
    songs = Song.all.select{|s| s.genre.name == search_for} # collects all songs for genre
    songs.sort_by{|s| s.name}.each_with_index do |s, i| # sorts genres by name
      puts "#{i+1}. #{s.artist.name} - #{s.name}" # puts out formatted artist and song name 
    end
  end

  def play_song
    puts "Which song number would you like to play?"    # asks user what to song to play
    input = gets.strip.to_i                             # collects input from user
    song = Song.all.sort_by{|s| s.name}[input-1]        # selects the song from Song.all array
    if input.between?(1, Song.all.count)                # checks if it's valid input
      puts "Playing #{song.name} by #{song.artist.name}"# puts out formatted response
    end
  end

  def cli_commands(input)  # executes methods based on input
    case input
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    end
  end

end

