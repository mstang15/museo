class Curator
  attr_reader :artists,
              :photographs
  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << Photograph.new(photo)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
  end

  def find_artist_by_id(id_number)
    @artists.find do |artist|
      artist.id == id_number
    end
  end

  def find_photograph_by_id(id_number)
    @photographs.find do |photograph|
      photograph.id == id_number
    end
  end

  def find_photographs_by_artist(artist)
    artist_id = artist.id
    @photographs.find_all do |photograph|
      photograph.artist_id == artist_id
    end
  end

  def hash_of_artist_id_and_photograph_count
    a = @photographs.inject(Hash.new(0)) do |total, photograph|
      total[photograph.artist_id] += 1
      total
    end
  end

  def artists_with_multiple_photographs
    artists_over_one = hash_of_artist_id_and_photograph_count.keep_if do |artist_id,count|
      count > 1
    end
    artists_over_one.keys.map do |artist_id|
      find_artist_by_id(artist_id)
    end
  end
end
