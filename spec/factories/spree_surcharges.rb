# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spree_surcharge, :class => 'Spree::Surcharge' do
    chargeable_rate_info nil
  end
end
