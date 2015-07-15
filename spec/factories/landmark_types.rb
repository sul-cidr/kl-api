# == Schema Information
#
# Table name: landmark_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryGirl.define do

  sequence :landmark_type_name do |n|
    "TYPE#{n}"
  end

  factory :landmark_type do

    name { generate(:landmark_type_name) }

    factory :landmark_type_with_landmarks do

      transient do
        landmarks_count 2
      end

      after(:create) do |type, ev|
        create_list(:landmark, ev.landmarks_count, landmark_type: type)
      end

    end

  end

end
