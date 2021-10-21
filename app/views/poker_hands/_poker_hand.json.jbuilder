json.extract! poker_hand, :id, :cards, :ranking_type, :rank_no, :is_ranking_type, :created_at, :updated_at
json.url poker_hand_url(poker_hand, format: :json)
