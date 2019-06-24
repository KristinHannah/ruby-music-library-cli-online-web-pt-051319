require_relative "./concerns/findable.rb"

class Genre 
  extend Concerns::Findable
  attr_accessor :name 
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
  end 
  
  def songs 
    @songs 
  end 
  
  def artists
    artists = []
    self.songs.each do |song|
     artists << song.artist 
   end 
   artists.uniq
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
    new_genre = self.new(name)
    new_genre.save 
    new_genre
  end 
  
end 