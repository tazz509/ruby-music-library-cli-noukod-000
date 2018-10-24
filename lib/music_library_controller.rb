require 'pry'
class MusicLibraryController
  def initialize path = "./db/mp3s"
    music_importer = MusicImporter.new path
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    loop do
      option = gets.chomp

      case option
        when "exit"
          break
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
      end
    end
  end

  def list_songs
    sorted_song_list = Song.all.sort_by do |song|
      song.name
    end
    sorted_song_list.uniq.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    sorted_artist_list = Artist.all.sort_by do |artist|
      artist.name
    end

    sorted_artist_list.uniq.each_with_index {|artist, index| puts "#{index + 1}. #{artist.name}"}
  end

  def list_genres
    sorted_genre_list = Genre.all.sort_by do |genre|
      genre.name
    end

    sorted_genre_list.uniq.each_with_index {|genre, index| puts "#{index + 1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp

    songs = Song.all.select {|song| song.artist.name == artist_name}

    sorted_song_list = songs.sort_by {|song| song.name}

    sorted_song_list.uniq.each_with_index {|song, index| puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp

    songs = Song.all.select {|song| song.genre.name == genre_name}

    sorted_song_list = songs.sort_by {|song| song.name}

    sorted_song_list.uniq.each_with_index {|song, index| puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
  end

  def play_song
    puts "Which song number would you like to play?"
    number = gets.chomp.to_i

    sorted_song_list = Song.all.sort_by do |song|
      song.name
    end

    sorted_uniq = sorted_song_list.uniq

    if number.between?(1, sorted_uniq.size + 1)
      song = sorted_uniq[number - 1]

      if song
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end
end
