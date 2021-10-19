class PokerHandService
  attr_accessor :poker_hand

  def initialize(poker_hand)
    @poker_hand = poker_hand
  end

  def rank_hand
    # there are 10 total rankings
    # check if user_poker_hand has cards in each ranking
    # if one matches return true else continue

    ranking_check = nil # array of methods
      # iterate through array and call methods
      ranking_check.each do |ranking_method|
      end
    end
  end

  private

  def is_five_of_a_kind
    'is_five_of_a_kind'
  end

  def is_straight_flush
    'is_straight_flush'
  end
end
