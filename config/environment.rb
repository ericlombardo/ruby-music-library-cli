require 'bundler'
Bundler.require
require 'pry'

module Concerns # holds all modules needed for application
  module Findable # holds genreic ways to find different names using self
    def find_by_name(name)
      self.all.detect{|s| s.name == name}
    end

    def find_or_create_by_name(name)
      checker = self.find_by_name(name)
      checker == nil ? self.create(name) : checker 
    end
  end
end

require_all 'lib'
