require 'pry'
require_relative '../config/environment.rb'


class MusicImporter
  
  
  def initialize(path)  # takes in path for files
    @path = path
  end

  def path  #=> path of files
    @path
  end

  def files
    start_location = Dir.pwd        # creates return point
    Dir.chdir path                  # changes path to where files are
    file_names = Dir.glob("*.mp3")  # assigns all mp3's to variable
    Dir.chdir start_location        # changes path back to original
    file_names                      #=> array of file_names
  end

  def import    # takes files array and for each one passes it to Song.create_from_filename
    files.each do |file_name|
      Song.create_from_filename(file_name)
    end
  end

end