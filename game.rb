require './computer_player'
require './user_player'
require './rules'
require './deck'

class Game
  include Rules

  def initialize
    @players = []
    @players << ComputerPlayer.new
  end

  def greeting
    puts 'Добро пожаловать в игру Блэк Джек'
  end

  def add_player
    name = ''
    while name.empty?
      puts 'Введите имя игрока'
      name = gets.chomp
      puts 'Имя не должно быть пустым' if name.empty?
    end

    @players.unshift(UserPlayer.new(name.capitalize))
  end

  def score_report
    @players.each(&:score_report)
  end

  def looser
    @players.detect { |player| player.score <= 0 }
  end

  def prepare_play
    @deck = Deck.new
    make_deposit
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def play
    prepare_play
    counter = 0

    loop do
      player = @players[counter]
      turns = player_turns(player)
      turn = player.make_turn(turns)

      if turn == :show_cards
        show_cards
        reset
        break
      end

      deal_cards(player) if turn == :deal_cards
      add_card(player) if turn == :add_card
      puts "#{player.name} пропускает ход" if turn == :skip

      counter = counter < @players.length - 1 ? counter + 1 : 0
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  private

  def deal_cards(player)
    puts "#{player.name} получает 2 карты"
    player.add_card(@deck.deal_card)
    player.add_card(@deck.deal_card)
  end

  def add_card(player)
    puts "#{player.name} получает карту"
    player.add_card(@deck.deal_card)
  end

  def show_cards
    @players.each(&:cards_report)
    winner = choose_winner(@players)
    if winner
      winner.set_off_bet
      puts "Выиграл #{winner.name}"
    else
      puts 'Ничья'
    end
  end

  def reset
    @players.each(&:drop_cards)
  end

  def make_deposit
    @players.each(&:make_deposit)
  end
end
