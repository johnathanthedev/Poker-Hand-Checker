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
    # ====================
    # A straight flush is a hand that contains five cards of sequential rank, all of the same suit, 
    # such as Q♥ J♥ 10♥ 9♥ 8♥ (a "queen-high straight flush").[4] It ranks below five of a kind and above four of a kind.
    # [6] Under high rules, an ace can rank either high (as in A♥ K♥ Q♥ J♥ 10♥, an ace-high straight flush) or low 
    # (as in 5♦ 4♦ 3♦ 2♦ A♦, a five-high straight flush), but cannot simultaneously rank both high and low 
    # (so Q♣ K♣ A♣ 2♣ 3♣ is an ace-high flush, but not a straight).[7][15] Under deuce-to-seven low rules, an ace always 
    # ranks high (so 5♠ 4♠ 3♠ 2♠ A♠ is an ace-high flush). Under ace-to-six low rules, an ace always rank low 
    # (so A♥ K♥ Q♥ J♥ 10♥ is a king-high flush).[16] Under ace-to-five low rules, straight flushes are not possible 
    # (so 9♣ 8♣ 7♣ 6♣ 5♣ is a nine-high hand).[8]
    # ====================
    yaml_service = YamlService.new
    straight_flush = yaml_service.get_file_contents["poker_hand"]["rankings"][1]
    notification_service = NotificationService.new(@poker_hand, straight_flush, 2)
    face_a = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][0].downcase
    face_k = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][1].downcase
    face_q = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][2].downcase
    face_j = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][3].downcase
    face_10 = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][4].to_s
    face_9 = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][5].to_s
    face_8 = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][6].to_s
    face_7 = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][7].to_s

    suits_only_arr = []
    unless !@poker_hand.include? 'jkr'
      notification_service.is_ranking_type = false
      notification_service
    else
      @poker_hand.each do |card|
        card_elms = card.split("")
        unless card_elms.length > 2
          card_elms.shift
          card_elms.join("")
          suit = card_elms
          suits_only_arr << suit
        else
          card_elms.shift(2)
          card_elms.join("")
          suit = card_elms
          suits_only_arr << suit
        end
      end  

      unique_suits_only_arr = suits_only_arr.flatten.uniq
      if unique_suits_only_arr.length == 1 
        # criteria: if one is present then other relying need to be present
        @poker_hand.each do |card|
          card_elms = card.split("")
          if card_elms.include? face_a
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_k
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_q
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_j
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_10
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_9
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_8
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_7
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          else
            notification_service.is_ranking_type = false
          end
        end
        notification_service    
      else
        notification_service.is_ranking_type = false
        notification_service  
      end
    end
  end

  def is_four_of_a_kind
    # ====================
    # Four of a kind, also known as quads, is a hand that contains four cards of one 
    # rank and one card of another rank (the kicker), such as 9♣ 9♠ 9♦ 9♥ J♥ 
    # ("four of a kind, nines"). It ranks below a straight flush and above a full house.[6]
    # Each four of a kind is ranked first by the rank of its quadruplet, and then by the rank of its 
    # kicker. For example, K♠ K♥ K♣ K♦ 3♥ ranks higher than 7♥ 7♦ 7♠ 7♣ Q♥, which ranks higher than 
    # 7♥ 7♦ 7♠ 7♣ 10♠. Four of a kind hands that differ by suit alone, such as 4♣ 4♠ 4♦ 4♥ 9♣ and 
    # 4♣ 4♠ 4♦ 4♥ 9♦, are of equal rank.[7][15]
    # ====================

    yaml_service = YamlService.new
    four_of_a_kind = yaml_service.get_file_contents["poker_hand"]["rankings"][2]
    notification_service = NotificationService.new(@poker_hand, four_of_a_kind, 3)
    face_a = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][0].downcase
    face_k = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][1].downcase
    face_q = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][2].downcase
    face_j = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][3].downcase
    face_10 = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][4].to_s
    face_9 = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][5].to_s
    face_8 = yaml_service.get_file_contents["poker_hand"]["types"]["faces"][6].to_s

    suits_only_arr = []
      @poker_hand.each do |card|
        card_elms = card.split("")
        unless card_elms.length > 2
          card_elms.shift
          card_elms.join("")
          suit = card_elms
          suits_only_arr << suit
        else
          card_elms.shift(2)
          card_elms.join("")
          suit = card_elms
          suits_only_arr << suit
        end
      end  

      unique_suits_only_arr = suits_only_arr.flatten.uniq
      if unique_suits_only_arr.length == 2 
        # criteria: if one is present then other relying need to be present
        @poker_hand.each do |card|
          card_elms = card.split("")
          if card_elms.include? face_a
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_k
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_q
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_j
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_10
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_9
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          elsif card_elms.include? face_8
            notification_service.is_ranking_type = true
            notification_service.send_notification
            break
          else
            notification_service.is_ranking_type = false
          end
        end
        notification_service    
      else
        notification_service.is_ranking_type = false
        notification_service  
      end
  end

  def is_full_house
    yaml_service = YamlService.new
    full_house = yaml_service.get_file_contents["poker_hand"]["rankings"][3]
    notification_service = NotificationService.new(@poker_hand, full_house)
    notification_service.is_ranking_type = true
    notification_service
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
