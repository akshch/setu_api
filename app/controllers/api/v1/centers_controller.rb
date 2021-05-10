class Api::V1::CentersController < ApplicationController

  def index
    result = ApiSetu.new.fetch_by_district(date: Date.today.strftime('%d-%m-%Y'))
    data = result["sessions"]
    data.each do |d|
    center = Center.where("center_id =? and created_at::date =?", d['center_id'], Date.today)
    if !center.exists?
      cntr = Center.create(center_id: d['center_id'].to_i, name: d['name'], address: d['address'], state_name: d['state_name'], district_name: d['district_name'], block_name: d['block_name'], pincode: d['pincode'], from: d['from'], to: d['to'], lat: d['lat'], long: d['long'], fee_type: d['fee_type'], session_id: d['session_id'], date: d['date'], available_capacity: d['available_capacity'], fee: d['fee'], min_age_limit: d['min_age_limit'], vaccine: d['vaccine'])
      d["slots"].each do |s|
        Slot.create(center_id: cntr.id, timing: s)
      end
    else
      CenterJob.new.perform_now(center.first)
    end
    end
  end
end
