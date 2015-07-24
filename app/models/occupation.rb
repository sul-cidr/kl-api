# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Occupation < ActiveRecord::Base

  has_many :person_occupations
  has_many :people, :through => :person_occupations

  validates :name, presence: true, uniqueness: true

  searchable do
    text :name, :stored => true
  end

end
