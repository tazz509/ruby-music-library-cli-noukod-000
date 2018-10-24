class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize name
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  

  def add_song song
    song.artist = self if song.artist.nil?
    @songs << song if (@songs.none? {|song_in_songs| song == song_in_songs})
  end

  def genres
    (@songs.collect {|song| song.genre}).uniq
  end
end
