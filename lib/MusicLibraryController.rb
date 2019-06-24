require "pry"

class MusicLibraryController
  attr_accessor :path, :music_library
   @@all = []
    
  def initialize(path = "./db/mp3s")
    @path = path 
    new = MusicImporter.new(path)
    @music_library =  new.import
    @@all << self
  end 
  
  def call 
    puts "Welcome to your music library!"
    input = ""
    
    while input != "exit"
      puts "To list all of your songs, enter 'list songs'." 
      puts "To list all of the artists in your library, enter 'list artists'." 
      puts "To list all of the genres in your library, enter 'list genres'." 
      puts "To list all of the songs by a particular artist, enter 'list artist'." 
      puts "To list all of the songs of a particular genre, enter 'list genre'." 
      puts "To play a song, enter 'play song'." 
      puts "To quit, type 'exit'." 
      puts "What would you like to do?" 
     input = gets.chomp
     if input == "list songs"
       list_songs 
      elsif input == "list artists"
        list_artists
      elsif input == "list genres"
        list_genres
      elsif input == 'list artist'
        list_songs_by_artist
      elsif input == "list genre"
        list_songs_by_genre
      elsif input == "play song"
        play_song
      end 
     end
  end 
  
   def stored_list
      store = []
        self.music_library.each do |song|
          store << Song.new_from_filename(song)
         end
          store
       end 
  
  def list_songs
        i = 1
      sorted_store = stored_list.sort_by {|song| song.name}
    sorted_store.each do |song| 
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      i +=1
    end
  end 
  
  def list_artists 
    i = 1 
    artists = stored_list.collect {|song| song.artist.name} 
    artists << Artist.all[0].name
   # binding.pry
    sorted_artists = artists.sort {|a,b| a <=> b} 
    sorted_artists.uniq.each do |name| 
      puts "#{i}. #{name}"
      i += 1 
    end 
  end
  
  def list_genres 
    i = 1 
    genres = stored_list.collect {|song| song.genre.name} 
    sorted_genres = genres.sort {|a,b| a <=> b} 
    sorted_genres.uniq.each do |genre|
      puts "#{i}. #{genre}"
      i += 1 
    end 
  end 
  
  def list_songs_by_artist
    i = 1
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artists_songs = stored_list.select {|song| song.artist.name == input}
    sorted = artists_songs.sort_by {|song| song.name}
    sorted.each do |song| 
      puts "#{i}. #{song.name} - #{song.genre.name}"
      i +=1
    end 
  end 
  
  def list_songs_by_genre 
     i = 1
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genres_songs = stored_list.select {|song| song.genre.name == input}
    sorted = genres_songs.sort_by {|song| song.name}
    sorted.each do |song| 
      puts "#{i}. #{song.artist.name} - #{song.name}"
      i +=1
    end 
  end 
  
  def play_song 
    puts "Which song number would you like to play?"
    input = gets.chomp
    num = input.to_i
    sorted_store = stored_list.sort_by {|song| song.name}
    
    info = []
    sorted_store.each do | song |
      info << "#{song.name} by #{song.artist.name}"
    end 
    if info.length >= num && num > 0 
     puts "Playing #{info[num - 1]}"
   end 
  end 
  
end 
