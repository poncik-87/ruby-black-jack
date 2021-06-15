require './computer_player.rb'
require './user_player.rb'

class Game
  def initialize
    @players = []
    @players << ComputerPlayer.new
  end

  def greeting
    puts 'Добро пожаловать в игру Блэк Джек'
  end

  def addPlayer
    name = ''
    while name.empty? do
      puts "Введите имя игрока"
      name = gets.chomp
      puts "Имя не должно быть пустым" if name.empty?
    end

    @players.unshift(UserPlayer.new(name))
  end

  def play
    puts '...is playing'
  end
end
