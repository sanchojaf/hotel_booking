# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spree_rate_info, :class => 'Spree::RateInfo' do
    room_rate_detail nil
  end
end
