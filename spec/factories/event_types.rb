# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryGirl.define do

  sequence :event_type_name do |n|
    "TYPE#{n}"
  end

  factory :event_type do

    name { generate(:event_type_name) }

    factory :event_type_with_events do

      transient do
        event_count 2
      end

      after(:create) do |type, ev|
        create_list(:event, ev.event_count, event_type: type)
      end

    end

  end

end
