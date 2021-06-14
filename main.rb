require './game.rb'

ANSWERS = %w[да нет]

game = Game.new
game.greeting
game.addPlayer

answer = "да"
while answer != 'нет'
  if answer == 'да'
    game.play
  else
    puts 'Введено невалидное значение (доступные варианты: да/нет)'
  end

  puts "Хотите сыграть еще? Да/Нет"
  answer = gets.chomp.downcase
end
