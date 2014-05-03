# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spree_bed_type, :class => 'Spree::BedType' do
    type_id "MyString"
    description "MyString"
    room_rate_detail nil
  end
end
