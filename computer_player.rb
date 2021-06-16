require './player.rb'
require './rules.rb'

ENOUGH_SCORE = 17

class ComputerPlayer < Player
  include Rules

  def initialize
    super('компьютер')
  end

  def make_turn(turns)
    return :deal_cards if turns.first == :deal_cards

    if (turns.include?(:add_card) && calc_score(self) < ENOUGH_SCORE)
      return :add_card
    end

    :skip
  end
end
