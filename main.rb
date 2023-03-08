require_relative 'lib/film'
require_relative 'lib/film_collection'

URL = 'https://w.wiki/6PCi'

collection = FilmCollection.kinopoisk(URL)

if collection.films.empty?
  puts 'Нет доступа к кинопоиску. Загружаю фильмы из локальной базы данных.'
  puts
  collection = FilmCollection.from_folder(Dir["#{__dir__}/data/*"])
end

puts 'Программа «Фильм на вечер»'

answer = 0

puts collection
puts
puts 'Фильм какого режиссера вы хотите сегодня посмотреть?'

answer = gets.to_i

loop do
  break if (1..collection.directors.size).include?(answer)

  puts 'Такого режиссера нет, введите индекс правильно!'
  answer = gets.to_i
end

director = collection.directors[answer - 1]
film = collection.films.select { |film| film.director == director }.sample

puts
puts 'И сегодня вечером рекомендую посмотреть:'
puts film
