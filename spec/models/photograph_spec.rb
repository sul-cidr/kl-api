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

RSpec.describe Photograph, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
