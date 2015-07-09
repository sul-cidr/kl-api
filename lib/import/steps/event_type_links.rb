
module Import
  class EventTypeLinks < Step

    @depends = [EventRows, EventTypeRows]

    def up
      @DB[:event].each do |e|

        # Find the matching type row.
        type = EventType.find_by(code: e[:type])

        if type
          Event.find_by(legacy_id: e[:recno]).update(
            event_type_id: type.id
          )
        end

      end
    end

    def down
      Event.update_all(birth_year: nil)
    end

    def satisfied?
      Event.where.not(event_type_id: nil).exists?
    end

  end
end
