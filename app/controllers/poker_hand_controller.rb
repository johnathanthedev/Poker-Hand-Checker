require './app/services/yaml_service'

class PokerHandController < ApplicationController
  def index 
  end

  def submit_hand
    yaml_service = YamlService.new
    poker_refs = yaml_service.get_file_contents
  end
end
