# == Schema Information
#
# Table name: landmark_types
#
#  id   :integer          not null, primary key
#  name :string
#

class LandmarkType < ActiveRecord::Base
  has_many :landmarks
  validates :name, presence: true, uniqueness: true
end
