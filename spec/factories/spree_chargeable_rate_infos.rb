# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spree_chargeable_rate_info, :class => 'Spree::ChargeableRateInfo' do
    rate_info nil
  end
end
