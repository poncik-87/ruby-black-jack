require './card.rb'

SUITS = %w[+ <3 ^ <>]
RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A]

class Deck
  def initialize
    @used_cards = []
  end

  def get_card
    loop do
      suit = SUITS.sample
      rank = RANKS.sample

      next if card_used?(suit, rank)

      card = Card.new(suit, rank)
      @used_cards << card
      return card
    end
  end

  private

  def card_used?(suit, rank)
    @used_cards.any? { |card| card.suit == suit && card.rank == rank }
  end
end
