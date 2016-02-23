# == Schema Information
#
# Table name: landmarks
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lonlat             :geometry({:srid= point, 0
#  start_year         :integer
#  opened             :integer
#  opened_qualifier   :string
#  closed             :integer
#  closed_qualifier   :string
#  location_qualifier :string
#  address_name       :string
#  address_street     :string
#  address_type       :string
#  address_postal     :string
#  priority           :integer
#  kb_association     :string
#  also_known_as      :string
#  category           :string
#  notes              :string
#  architect          :string
#  artist             :string
#  denomination       :string
#  monument_type      :string
#  physical_type      :string
#  monument_subject   :string
#  monument_sphere_1  :string
#  monument_sphere_2  :string
#  monument_sphere_3  :string
#  monument_patronage :string
#  monument_legend    :string
#  person_dates       :string
#  research_questions :string
#  branch             :string
#  kb_tag             :string
#  kb_subtag          :string
#  kb_extra_tag       :string
#  court_type         :string
#  railway_line       :string
#  drama_category     :string
#

class Landmark < ActiveRecord::Base

  include GeoSearchable

  searchable do
    text :name, :stored => true
  end

end
