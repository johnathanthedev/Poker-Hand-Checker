class CreatePokerHands < ActiveRecord::Migration[6.1]
  def change
    create_table :poker_hands do |t|
      t.string :cards
      t.string :ranking_type
      t.integer :rank_no
      t.boolean :is_ranking_type

      t.timestamps
    end
  end
end
