module Concerns::Findable
  def find_by_name name
    all.find {|object| object.name == name}
  end

  def find_or_create_by_name name
    object = find_by_name name
    if (object)
      object
    else
      create name
    end
  end

  def create name
    self.new(name).tap do |object|
      all << object
    end
  end
end
