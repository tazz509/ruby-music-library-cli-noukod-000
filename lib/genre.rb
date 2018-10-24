class Genre
  extend Concerns::Findable

  attr_accessor :name
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

  def self.create name
    Genre.new(name).tap do |genre|
      @@all << genre
    end
  end

  def songs
    @songs
  end

  def add_song song
    @songs << song if (@songs.none? {|song_in_songs| song == song_in_songs})
  end

  def artists
    (@songs.collect {|song| song.artist}).uniq
  end
end
