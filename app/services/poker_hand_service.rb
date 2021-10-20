require './app/services/notification_service'
require './app/services/yaml_service'

class PokerHandService
  attr_accessor :poker_hand, :rank

  def initialize(poker_hand)
    @poker_hand = poker_hand
    @rank = nil
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
      unless ranking_method.is_ranking_type
        @rank = ranking_method
      else
        @rank = ranking_method
        break
      end
    end
    @rank
  end

  private

  def is_five_of_a_kind
    # ====================
    # Five of a kind is a hand that contains five cards of one rank, such as 3♥ 3♦ 3♣ 3♠ JKR ("five of a kind, threes"). 
    # It ranks above a straight flush but is only possible when using one or more wild cards, as there are only four cards of each rank in the deck.
    # [7] Five of a kind, aces, A♥ A♦ A♣ A♠ Jkr, becomes possible when a joker is added to the deck as a bug, a form of wild card that may act as a fifth ace.
    # [6] Other wild card rules allow jokers or other designated cards to represent any card in the deck, making it possible to form five of a kind of any rank.
    # [14]
    # ====================
    yaml_service = YamlService.new
    five_of_a_kind = yaml_service.get_file_contents["poker_hand"]["rankings"][0]
    notification_service = NotificationService.new(@poker_hand, five_of_a_kind, 1)

    suitless_cards_arr = []
    @poker_hand.each do |card|
      split_card_elms = card.split('')
      unless split_card_elms.last != 'r'
        wildcard_set = split_card_elms.join
        suitless_cards_arr << wildcard_set
      else
        split_card_elms.pop()
        joined_card_elms = split_card_elms.join
        suitless_cards_arr << joined_card_elms  
      end
    end   
    
    unique_suitless_cards = suitless_cards_arr.uniq.sort # Joker card always last
    unless unique_suitless_cards.length == 2 && unique_suitless_cards.last == 'jkr'
      notification_service.is_ranking_type = false
      notification_service
    else
      notification_service.is_ranking_type = true
      notification_service.send_notification
      notification_service
    end
  end

  def is_straight_flush
    yaml_service = YamlService.new
    straight_flush = yaml_service.get_file_contents["poker_hand"]["rankings"][1]
    notification_service = NotificationService.new(@poker_hand, straight_flush, 2)
    notification_service.is_ranking_type = true
    notification_service.send_notification
    notification_service
    # what makes a hand x
    # is_straight_flush= notification_service.is_ranking_type
  end

  def is_four_of_a_kind
    yaml_service = YamlService.new
    four_of_a_kind = yaml_service.get_file_contents["poker_hand"]["rankings"][2]
    notification_service = NotificationService.new(@poker_hand, four_of_a_kind)
    # what makes a hand x
    is_four_of_a_kind = !notification_service.is_ranking_type
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
