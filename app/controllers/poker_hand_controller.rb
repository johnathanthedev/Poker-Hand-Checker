require './app/services/yaml_service'
require './app/services/poker_hand_service'

class PokerHandController < ApplicationController
  def index 
  end

  def submit_hand
    user_poker_hand = params[:poker_hand].split(" ")
    yaml_service = YamlService.new
    poker_hand_service = PokerHandService.new(user_poker_hand)
    puts poker_hand_service.rank_hand
  end
end