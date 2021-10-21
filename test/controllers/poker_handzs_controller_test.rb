require "test_helper"

class PokerHandzsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poker_handz = poker_handzs(:one)
  end

  test "should get index" do
    get poker_handzs_url
    assert_response :success
  end

  test "should get new" do
    get new_poker_handz_url
    assert_response :success
  end

  test "should create poker_handz" do
    assert_difference('PokerHandz.count') do
      post poker_handzs_url, params: { poker_handz: { cards: @poker_handz.cards, is_ranking_type: @poker_handz.is_ranking_type, rank_no: @poker_handz.rank_no, ranking_type: @poker_handz.ranking_type } }
    end

    assert_redirected_to poker_handz_url(PokerHandz.last)
  end

  test "should show poker_handz" do
    get poker_handz_url(@poker_handz)
    assert_response :success
  end

  test "should get edit" do
    get edit_poker_handz_url(@poker_handz)
    assert_response :success
  end

  test "should update poker_handz" do
    patch poker_handz_url(@poker_handz), params: { poker_handz: { cards: @poker_handz.cards, is_ranking_type: @poker_handz.is_ranking_type, rank_no: @poker_handz.rank_no, ranking_type: @poker_handz.ranking_type } }
    assert_redirected_to poker_handz_url(@poker_handz)
  end

  test "should destroy poker_handz" do
    assert_difference('PokerHandz.count', -1) do
      delete poker_handz_url(@poker_handz)
    end

    assert_redirected_to poker_handzs_url
  end
end
