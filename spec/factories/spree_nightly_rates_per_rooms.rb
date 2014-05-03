# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spree_nightly_rates_per_room, :class => 'Spree::NightlyRatesPerRoom' do
    chargeable_rate_info nil
  end
end
