# == Schema Information
#
# Table name: relations
#
#  id        :integer          not null, primary key
#  source_id :integer          not null
#  target_id :integer          not null
#

require 'rails_helper'

describe Relation, type: :model do

  describe "associatons" do

    it do
      should belong_to(:source)
        .class_name("Person")
        .with_foreign_key("source_id")
    end

    it do
      should belong_to(:target)
        .class_name("Person")
        .with_foreign_key("target_id")
    end

  end

end
