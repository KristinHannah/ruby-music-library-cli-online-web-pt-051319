require "pry"

class Song 
  attr_accessor :name, :genre
  attr_reader :artist
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist=(artist) if artist 
    self.genre=(genre) if genre 
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
    artist
  end 
  
  def genre=(genre)
    @genre = genre 
    genre.songs << self unless genre.songs.include?(self) 
    genre
  end 
  
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}    
  end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
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
    new_song = self.new(name)
    new_song.save 
    new_song
  end 
  
  def self.new_from_filename(fileName)
    file_array = fileName.split(" - ")
    artist = file_array[0]
    artist = Artist.find_or_create_by_name(artist)
    song_name = file_array[1]
    genre = file_array[2]
    genre = genre[0...-4]
    genre = Genre.find_or_create_by_name(genre)
    self.find_by_name(song_name) || self.new(song_name, artist, genre)
  end 
  
  def self.create_from_filename(fileName)
    self.new_from_filename(fileName).save
  end 
  
end 

