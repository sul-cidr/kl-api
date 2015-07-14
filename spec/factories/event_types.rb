# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryGirl.define do

  sequence :name do |n|
    "TYPE#{n}"
  end

  factory :event_type do

    name

    factory :event_type_with_events do

      transient do
        events_count 2
      end

      after(:create) do |event_type, evaluator|
        create_list(:event, evaluator.events_count, event_type: event_type)
      end

    end

  end

end
