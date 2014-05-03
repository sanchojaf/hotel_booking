# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spree_smoking_preference, :class => 'Spree::SmokingPreference' do
    value "MyString"
    room_rate_detail nil
  end
end
