require './lib/file_io'

class Curator<FileIO
  attr_accessor :artists,
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

  def artists_from_certain_country(country_)
    artists = @artists.find_all do |artist|
      artist.country == country_
    end
    artists.map do |artist|
      artist.id
    end
  end

  def photographs_taken_by_artists_from(country)
    artist_ids = artists_from_certain_country(country)
    @photographs.find_all do |photograph|
      artist_ids.include?(photograph.artist_id)
    end
  end

  def load_photographs(file)
    super(file)
  end

  def load_artists(file)
    super(file)
  end

  def photographs_taken_between(range)
    a = @photographs.find_all do |photograph|
      range.include?(photograph.year.to_i)
    end
  b =   a.map do |photograph|
      find_photograph_by_id(photograph.id)
    end
  end

  def artists_photographs_by_age(artist)
    photos = find_photographs_by_artist(artist)
    ages = find_age_of_artists_at_time_of_photo(photos)
    titles = find_name_of_photographs(photos)
    a = ages.zip(titles).to_h
    binding.pry
  end

  def find_name_of_photographs(photo_array)
    photo_array.map do |photo|
      photo.name
    end
  end
  def find_age_of_artists_at_time_of_photo(photo_array)
    artist = find_artist_by_id(photo_array[0].artist_id)
    photo_array.map do |photo|
      photo.year.to_i - artist.born.to_i
    end
  end


end
