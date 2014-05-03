# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spree_room_rate_detail, :class => 'Spree::RoomRateDetail' do
    hotel_summary nil
  end
end
