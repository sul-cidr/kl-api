# == Schema Information
#
# Table name: monuments
#
#  id            :integer          not null, primary key
#  name          :string
#  unveiled_year :integer
#  lonlat        :geometry({:srid= point, 0
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Monument, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
