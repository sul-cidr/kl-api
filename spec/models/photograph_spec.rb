# == Schema Information
#
# Table name: photographs
#
#  id         :integer          not null, primary key
#  slug       :string
#  lonlat     :geometry({:srid= point, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Photograph, type: :model do
  # TODO
end
