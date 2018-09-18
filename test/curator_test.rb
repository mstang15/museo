require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/curator'
require './lib/artist'
require './lib/photograph'

class CuratorTest <Minitest::Test
  def test_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_artists_and_photographs_start_as_empty_arrays
    curator = Curator.new

    assert_equal [], curator.artists
    assert_equal [], curator.photographs
  end

  def test_it_can_add_photographs
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_instance_of Array, curator.photographs
    assert_equal 2, curator.photographs.length
    assert_instance_of Photograph, curator.photographs.first
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", curator.photographs.first.name
  end

  def test_it_can_add_artists
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_instance_of Array, curator.artists
    assert_equal 2, curator.artists.length
    assert_instance_of Artist, curator.artists.first
    assert_equal "Henri Cartier-Bresson", curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal "Henri Cartier-Bresson", curator.find_artist_by_id("1").name
    assert_instance_of Artist, curator.find_artist_by_id("1")
  end

  def test_it_can_find_photograph_by_id
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_equal "Moonrise, Hernandez",   curator.find_photograph_by_id("2").name
    assert_instance_of Photograph, curator.find_photograph_by_id("2")
  end
end
