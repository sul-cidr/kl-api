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

describe Monument, type: :model do

  describe "indexes" do
    it { should have_db_index(:lonlat) }
  end

end
