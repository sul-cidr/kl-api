# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do

  sequence :occupation_name do |n|
    "Occupation #{n}"
  end

  factory :occupation do

    name { generate(:occupation_name) }

    factory :occupation_with_people do

      transient do
        people_count 2
      end

      # Link people -> occupation with person_occupation rows.
      after(:create) do |occupation, ev|
        create_list(:person, ev.people_count).each do |p|
          create(:person_occupation, occupation: occupation, person: p)
        end
      end

    end

  end

end
