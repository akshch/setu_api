class CenterJob < ApplicationJob
  queue_as :default

  def perform(center=nil)
    if center.present?
      cntr = Center.find_by(id: center.id)
      cntr.send_message_to_telegram
    else
      Api::V1::CentersController.new.index
      Api::V1::CentersController.new.pincode
    end
  end
end
