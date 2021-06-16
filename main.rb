require './game.rb'

ANSWERS = %w[да нет]

game = Game.new
game.greeting
game.addPlayer
game.score_report

answer = "да"
while answer != 'нет'
  if answer == 'да'
    game.play
  else
    puts 'Введено невалидное значение (доступные варианты: да/нет)'
  end

  game.score_report

  looser = game.looser
  if (looser)
    puts "#{looser.name} проиграл. У него закончились деньги."
    break
  end

  puts "Хотите сыграть еще? Да/Нет"
  answer = gets.chomp.downcase
end
