# == Schema Information
#
# Table name: roles
#
#  id   :integer          not null, primary key
#  name :string           not null
#


class Role < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
