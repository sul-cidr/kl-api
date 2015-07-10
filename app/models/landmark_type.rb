# == Schema Information
#
# Table name: landmark_types
#
#  id   :integer          not null, primary key
#  name :string
#

class LandmarkType < ActiveRecord::Base
  validates :name, uniqueness: true
end
