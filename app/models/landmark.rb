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

  searchable do
    text :name, :stored => true
  end

  #
  # Match events of 1+ type.
  #
  # @param ids [Integer]
  #
  def self.by_types(*ids)
    where { landmark_type_id >> ids }
  end

end
