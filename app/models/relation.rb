# == Schema Information
#
# Table name: relations
#
#  id        :integer          not null, primary key
#  source_id :integer          not null
#  target_id :integer          not null
#

class Relation < ActiveRecord::Base

  belongs_to :source, class_name: "Person", foreign_key: "source_id"
  belongs_to :target, class_name: "Person", foreign_key: "target_id"

  #
  # Register directed edges between all pairs of people who are linked via
  # events of type "birth" or "marriage."
  #
  def self.index

    # clear existing rows
    # loop over events of type birth or marriage
    # for each event, get associated people
    # register relation edges for each pair

  end

end
