# == Schema Information
#
# Table name: landmarks
#
#  id               :integer          not null, primary key
#  name             :string
#  landmark_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  lonlat           :geometry({:srid= point, 0
#

class Landmark < ActiveRecord::Base

  include GeoSearchable

  belongs_to :landmark_type

  #
  # Match events of a given type.
  #
  # @param id [Integer]
  #
  def self.by_type(id)
    where { landmark_type_id == id }
  end

end
