require './user_player'
require './computer_player'

RANK_VALUE = {
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  '10' => 10,
  'J' => 10,
  'Q' => 10,
  'K' => 10,
  'A' => 11
}.freeze
ACE_VALUES_DIF = 10
MAX_SCORE = 21

module Rules
  # rubocop:disable Metrics/CyclomaticComplexity
  def player_turns(player)
    return [:deal_cards] if player.cards.empty?
    return %i[skip add_card show_cards] if player.cards.length == 2 && player.instance_of?(UserPlayer)
    return %i[skip show_cards] if player.instance_of?(UserPlayer)
    return %i[skip add_card] if player.cards.length == 2 && player.instance_of?(ComputerPlayer)
    return [:skip] if player.instance_of?(ComputerPlayer)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def choose_winner(players)
    return if equal_score?(players)

    players.max { |a, b| calc_score(a) <=> calc_score(b) }
  end

  def equal_score?(players)
    score = calc_score(players.first)
    players.none? { |player| calc_score(player) != score }
  end

  def calc_score(player)
    sum = 0
    aces = 0

    player.cards.each do |card|
      aces += 1 if card.rank == :A
      sum += RANK_VALUE[card.rank]
    end

    aces.times do
      sum -= ACE_VALUES_DIF if sum > MAX_SCORE
    end

    sum > MAX_SCORE ? 0 : sum
  end
end
