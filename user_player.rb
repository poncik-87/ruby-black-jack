require './player'

TURNS = {
  skip: 'Пропустить ход',
  add_card: 'Добавить карту',
  show_cards: 'Вскрыть карты'
}.freeze

class UserPlayer < Player
  def make_turn(turns)
    return :deal_cards if turns.first == :deal_cards

    cards_report
    choose_turn(turns)
  end

  private

  def choose_turn(turns)
    loop do
      puts 'Выберите действие (введите цифру соответствующую действию):'
      puts turns_to_s(turns)
      turn_idx = gets.chomp.to_i
      return turns[turn_idx - 1] if turn_idx.positive? && turn_idx <= turns.length

      puts 'Неверно выбрано действие'
    end
  end

  def turns_to_s(turns)
    turns
      .map.with_index { |turn, idx| "#{idx + 1}. #{TURNS[turn]}" }
      .join(' ')
  end
end
