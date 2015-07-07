# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Occupation < ActiveRecord::Base

  has_many :occupation_people
  has_many :people, :through => :occupation_people

  validates :name, uniqueness: true

end
