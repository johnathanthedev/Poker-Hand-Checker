require 'application_system_test_case'

class PokerHandsTest < ApplicationSystemTestCase
  setup do
    @poker_hand = poker_hands(:one)
  end

  test 'visiting the index' do
    visit poker_hands_url
    assert_selector 'h1', text: 'Poker Hands'
  end

  test 'creating a Poker hand' do
    visit poker_hands_url
    click_on 'New Poker Hand'

    fill_in 'Cards', with: @poker_hand.cards
    check 'Is ranking type' if @poker_hand.is_ranking_type
    fill_in 'Rank no', with: @poker_hand.rank_no
    fill_in 'Ranking type', with: @poker_hand.ranking_type
    click_on 'Create Poker hand'

    assert_text 'Poker hand was successfully created'
    click_on 'Back'
  end

  test 'updating a Poker hand' do
    visit poker_hands_url
    click_on 'Edit', match: :first

    fill_in 'Cards', with: @poker_hand.cards
    check 'Is ranking type' if @poker_hand.is_ranking_type
    fill_in 'Rank no', with: @poker_hand.rank_no
    fill_in 'Ranking type', with: @poker_hand.ranking_type
    click_on 'Update Poker hand'

    assert_text 'Poker hand was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Poker hand' do
    visit poker_hands_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Poker hand was successfully destroyed'
  end
end
