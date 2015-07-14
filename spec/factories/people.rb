# == Schema Information
#
# Table name: people
#
#  id          :integer          not null, primary key
#  family_name :string
#  given_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sex         :string
#  birth_year  :integer
#  death_year  :integer
#  legacy_id   :string
#  birth_est   :boolean
#  death_est   :boolean
#

FactoryGirl.define do

  sequence :person_legacy_id do |n|
    "I#{n}"
  end

  factory :person do

    family_name   "William"
    given_name    "Shakespeare"
    sex           "M"
    birth_year    1564
    death_year    1616

    legacy_id { generate(:person_legacy_id) }

  end

end
