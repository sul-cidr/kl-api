# == Schema Information
#
# Table name: landmarks
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lonlat        :geometry({:srid= point, 0
#  unveiled_year :integer
#

class Landmark < ActiveRecord::Base

  include GeoSearchable

  searchable do
    text :name, :stored => true
  end

end
