# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legacy_id     :integer
#  event_type_id :integer
#  date          :date
#  year          :integer
#  year_est      :boolean
#

FactoryGirl.define do
  factory :event do
    
  end

end
