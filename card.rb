class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit, @rank = suit, rank
  end

  def to_s
    "#{rank}#{suit}"
  end
end
