INITIAL_SCORE = 100
BET = 10

class Player
  attr_reader :name, :cards, :score

  def initialize(name)
    @name = name
    @cards = []
    @score = INITIAL_SCORE
  end

  def add_card(card)
    cards << card
  end

  def drop_cards
    @cards = []
  end

  def cards_report
    cards_s = cards.map(&:to_s).join(', ')
    puts "#{name}, карты: #{cards_s}"
  end

  def score_report
    puts "#{name}, счет: #{score}"
  end

  def make_deposit
    @score -= BET
  end

  def set_off_bet
    @score += BET * 2
  end
end
