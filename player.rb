class Player
  attr_reader :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def add_card(card)
    cards << card
  end

  def drop_cards
    @cards = []
  end

  def cards_report
    cards_s = cards
      .map { |card| card.to_s}
      .join(', ')

    puts "#{name}, карты: #{cards_s}"
  end
end
