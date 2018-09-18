require 'csv'

class FileIO
  def load_artists(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.each do |row|
      artist_hash = {
        id: row[:id],
        name: row[:name],
        born: row[:born],
        died: row[:died],
        country: row[:country]
      }
      artists << Artist.new(artist_hash)
    end
    return artists
  end

  def load_photographs(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.each do |row|
      photograph_hash = {
        id: row[:id],
        name: row[:name],
        artist_id: row[:artist_id],
        year: row[:year],
      }
      photographs << Photograph.new(photograph_hash)
    end
    return photographs
  end
end
