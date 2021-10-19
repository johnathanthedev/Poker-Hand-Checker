class NotificationService
  attr_reader :is_ranking_type, :notification_type

  def initialize(poker_hand, ranking_type, notification_type = 'default')
    @poker_hand = poker_hand
    @ranking_type = ranking_type
    @notification_type = notification_type
    @is_ranking_type = false
  end

  def send_notification
    # some logic here
  end
end
