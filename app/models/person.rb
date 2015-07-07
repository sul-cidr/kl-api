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
#  birth_circa :boolean
#  death_circa :boolean
#

class Person < ActiveRecord::Base

  has_many :occupation_people
  has_many :occupations, :through => :occupation_people

  has_many :participations
  has_many :events, :through => :participations

  validates :legacy_id, uniqueness: true

end
