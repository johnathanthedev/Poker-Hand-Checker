class NotificationService
  attr_reader :ranking_type, :notification_type
  attr_accessor :is_ranking_type, :message, :rank_no

  def initialize(poker_hand, ranking_type, rank_no = 0, notification_type = 'default')
    @poker_hand = poker_hand
    @ranking_type = ranking_type
    @notification_type = notification_type
    @rank_no = rank_no
    @is_ranking_type = false
    @message = nil
  end

  def send_notification
    @message = "Your hand is #{ranking_type} & is ranked No. #{rank_no}"
  end
end
