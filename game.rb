require './computer_player.rb'
require './user_player.rb'
require './rules.rb'
require './deck.rb'

class Game
  include Rules

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

    @players.unshift(UserPlayer.new(name.capitalize))
  end

  def play
    @deck = Deck.new
    counter = 0

    loop do
      player = @players[counter]
      turns = player_turns(player)
      turn = player.make_turn(turns)

      if (turn == :show_cards)
        show_cards
        reset
        break
      end

      deal_cards(player) if turn == :deal_cards
      add_card(player) if turn == :add_card
      puts "#{player.name} пропускает ход" if turn == :skip

      counter = counter < @players.length - 1 ? counter + 1 : 0;
    end
  end

  private

  def deal_cards(player)
    puts "#{player.name} получает 2 карты"
    player.add_card(@deck.get_card)
    player.add_card(@deck.get_card)
  end

  def add_card(player)
    puts "#{player.name} получает карту"
    player.add_card(@deck.get_card)
  end

  def show_cards
    @players.each { |player| player.cards_report }
    winner = choose_winner(@players)
    if (winner)
      puts "Выиграл #{winner.name}"
    else
      puts 'Ничья'
    end
  end

  def reset
    @players.each { |player| player.drop_cards }
  end
end
