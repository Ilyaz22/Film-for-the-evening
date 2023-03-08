require 'nokogiri'
require 'httparty'
require_relative 'film'

class FilmCollection
  attr_reader :films, :directors

  def self.kinopoisk(url)
    doc = Nokogiri::HTML(HTTParty.get(url).body)

    films =
      doc.xpath("//tr").map do |el|
        Film.new(
          el.css('td[2]').text.chomp,
          el.css('td[3]').text.to_i,
          el.css('td[4]').text.chomp
        )
      end

    films = films.drop(1)

    FilmCollection.new(films)

    rescue SocketError
      new([])
  end

  def self.from_folder(dir)
    films = dir.map do |file_path|
      lines = File.readlines(file_path, chomp: true)
      Film.new(lines[0], lines[1], lines[2])
    end

    new(films)
  end

  def initialize(films)
    @films = films
    @directors = films.map(&:director).uniq
  end

  def to_s
    @directors.map.with_index(1) do |director, index|
      "#{index}. #{director}"
    end.join("\n")
  end
end
