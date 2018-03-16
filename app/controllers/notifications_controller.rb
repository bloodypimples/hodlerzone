class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(receiver_id: current_user.id)
    @notifications.update_all(read_at: Time.zone.now)
  end
end
