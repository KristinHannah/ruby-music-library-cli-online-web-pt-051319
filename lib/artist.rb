require "pry"
require_relative "./concerns/findable.rb"

class Artist 
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
  end 
  
  def songs 
    @songs
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    self.all.clear
  end 
  
  def save
    @@all << self 
  end 
  
  def self.create(name)
    new_artist = self.new(name)
    new_artist.save 
    new_artist
  end 
  
  def add_song(song_name)
    if song_name.artist == nil 
       song_name.artist = self 
   end 
   self.songs << song_name unless @songs.include?(song_name)
  end 
  
  def genres 
     genres = []
     self.songs.each do |song|
      genres << song.genre 
   end 
   genres.uniq
  end 
  
end 