require "application_system_test_case"

class PokerHandzsTest < ApplicationSystemTestCase
  setup do
    @poker_handz = poker_handzs(:one)
  end

  test "visiting the index" do
    visit poker_handzs_url
    assert_selector "h1", text: "Poker Handzs"
  end

  test "creating a Poker handz" do
    visit poker_handzs_url
    click_on "New Poker Handz"

    fill_in "Cards", with: @poker_handz.cards
    check "Is ranking type" if @poker_handz.is_ranking_type
    fill_in "Rank no", with: @poker_handz.rank_no
    fill_in "Ranking type", with: @poker_handz.ranking_type
    click_on "Create Poker handz"

    assert_text "Poker handz was successfully created"
    click_on "Back"
  end

  test "updating a Poker handz" do
    visit poker_handzs_url
    click_on "Edit", match: :first

    fill_in "Cards", with: @poker_handz.cards
    check "Is ranking type" if @poker_handz.is_ranking_type
    fill_in "Rank no", with: @poker_handz.rank_no
    fill_in "Ranking type", with: @poker_handz.ranking_type
    click_on "Update Poker handz"

    assert_text "Poker handz was successfully updated"
    click_on "Back"
  end

  test "destroying a Poker handz" do
    visit poker_handzs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Poker handz was successfully destroyed"
  end
end
