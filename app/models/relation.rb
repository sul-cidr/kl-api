class Relation < ActiveRecord::Base
  belongs_to :source, class_name: "Person", foreign_key: "source_id"
  belongs_to :target, class_name: "Person", foreign_key: "target_id"
end
