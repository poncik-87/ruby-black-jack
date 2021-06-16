require './player'
require './rules'

ENOUGH_SCORE = 17

class ComputerPlayer < Player
  include Rules

  def initialize
    super('компьютер')
  end

  def make_turn(turns)
    return :deal_cards if turns.first == :deal_cards

    return :add_card if turns.include?(:add_card) && calc_score(self) < ENOUGH_SCORE

    :skip
  end
end
