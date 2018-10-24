class MusicImporter
  attr_accessor :path

  def initialize path
    @path = path
  end

  def files
    filenames = Dir["#{path}/*.mp3"]
    filenames.collect {|filename| filename.split("/").last}
  end

  def import
    files.each do |filename|
      Song.create_from_filename filename
    end
  end
end
