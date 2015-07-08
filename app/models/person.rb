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

class Person < ActiveRecord::Base

  has_many :person_occupations
  has_many :occupations, :through => :person_occupations

  has_many :person_events
  has_many :events, :through => :person_events

  validates :legacy_id, uniqueness: true

end
