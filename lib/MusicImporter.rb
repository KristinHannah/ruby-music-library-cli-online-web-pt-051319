
class MusicImporter 
  attr_accessor :path
  
  def initialize(path)
    @path = path 
  end 
  
  
   def import 
    files.each do |file|
      Song.create_from_filename(file)
    end 
  end 
  
  def files
    Dir.entries(self.path).select {|file| file.end_with?(".mp3")}
  end  
  
  def path 
    @path 
  end 
  
end 