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
#


FactoryGirl.define do
  factory :person do
    family_name   "William"
    given_name    "Shakespeare"
    sex           "M"
    birth_year    1564
    death_year    1616
    legacy_id     "I2000"
  end
end
