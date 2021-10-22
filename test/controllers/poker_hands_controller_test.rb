require 'test_helper'

class PokerHandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poker_hand = poker_hands(:one)
  end

  test 'should get index' do
    get poker_hands_url
    assert_response :success
  end

  test 'should get new' do
    get new_poker_hand_url
    assert_response :success
  end

  test 'should create poker_hand' do
    assert_difference('PokerHand.count') do
      post poker_hands_url,
           params: { poker_hand: { cards: @poker_hand.cards, is_ranking_type: @poker_hand.is_ranking_type,
                                   rank_no: @poker_hand.rank_no, ranking_type: @poker_hand.ranking_type } }
    end

    assert_redirected_to poker_hand_url(PokerHand.last)
  end

  test 'should show poker_hand' do
    get poker_hand_url(@poker_hand)
    assert_response :success
  end

  test 'should get edit' do
    get edit_poker_hand_url(@poker_hand)
    assert_response :success
  end

  test 'should update poker_hand' do
    patch poker_hand_url(@poker_hand),
          params: { poker_hand: { cards: @poker_hand.cards, is_ranking_type: @poker_hand.is_ranking_type,
                                  rank_no: @poker_hand.rank_no, ranking_type: @poker_hand.ranking_type } }
    assert_redirected_to poker_hand_url(@poker_hand)
  end

  test 'should destroy poker_hand' do
    assert_difference('PokerHand.count', -1) do
      delete poker_hand_url(@poker_hand)
    end

    assert_redirected_to poker_hands_url
  end
end
