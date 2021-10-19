require './app/services/notification_service'
require './app/services/yaml_service'

class PokerHandService
  attr_accessor :poker_hand

  def initialize(poker_hand)
    @poker_hand = poker_hand
  end

  def rank_hand
    ranking_check = [
      method(:is_five_of_a_kind),
      method(:is_straight_flush),
      method(:is_four_of_a_kind),
      method(:is_full_house),
      method(:is_flush),
      method(:is_straight),
      method(:is_three_of_a_kind),
      method(:is_two_pair),
      method(:is_one_pair),
      method(:is_high_card)
    ]

    ranking_check.map do |method|
      ranking_method = method.call

      if ranking_method
        puts ranking_method
        break
      else
        puts 'RETURNED FALSE'
      end
    end
  end

  private

  def is_five_of_a_kind
    yaml_service = YamlService.new
    five_of_a_kind = yaml_service.get_file_contents['poker_hand']['rankings'][0]
    notification_service = NotificationService.new(@poker_hand, five_of_a_kind)
    # what makes a hand five of a kind
    is_five_of_a_kind = notification_service.is_ranking_type
  end

  def is_straight_flush
    # 'is_straight_flush'
    true
  end

  def is_four_of_a_kind
    # 'is_four_of_a_kind'
    false
  end

  def is_full_house
    'is_full_house'
  end

  def is_flush
    'is_flush'
  end

  def is_straight
    'is_straight'
  end

  def is_three_of_a_kind
    'is_three_of_a_kind'
  end

  def is_two_pair
    'is_two_pair'
  end

  def is_one_pair
    'is_one_pair'
  end

  def is_high_card
    'is_high_card'
  end
end
