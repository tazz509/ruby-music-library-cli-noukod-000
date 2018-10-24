class Song
  extend Concerns::Findable

  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize name, artist = nil, genre = nil
    @name = name
    self.artist= artist unless artist.nil?
    self.genre= genre unless genre.nil?
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
    Song.new(name).tap do |song|
      @@all << song
    end
  end

  def artist= artist
    @artist = artist
    artist.add_song self
  end

  def genre= genre
    @genre = genre
    genre.add_song self
  end

  def self.new_from_filename filename
    song_info = filename.split(" - ")

    name = song_info[1]
    artist_name = song_info[0]
    genre_name = song_info[2].split(".")[0]

    song = self.find_or_create_by_name name
    artist = Artist.find_or_create_by_name artist_name
    genre = Genre.find_or_create_by_name genre_name

    song.artist = artist
    song.genre = genre

    song
  end

  def self.create_from_filename filename
    @@all << (self.new_from_filename filename)
  end
end
