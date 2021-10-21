require './app/services/poker_hand_service'

class PokerHandController < ApplicationController
  def index
    poker_hand_service = PokerHandService.new([''])
    @ranked_hand = poker_hand_service.rank_hand
  end

  def submit_hand
    user_poker_hand = params[:poker_hand].split(' ')
    poker_hand_service = PokerHandService.new(user_poker_hand)
    @ranked_hand = poker_hand_service.rank_hand
  end
end