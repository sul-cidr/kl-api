# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Occupation, type: :model do

  describe "validations" do
    it { should validate_uniqueness_of :name }
  end

end
