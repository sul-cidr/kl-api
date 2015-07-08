
module Import
  class PersonEventRows < Step

    @depends = [PersonRows, EventRows]

    def _up
      @DB[:particip].each do |p|

        person = Person.find_by(legacy_id: p[:actor_id])
        event = Event.find_by(legacy_id: p[:event_id])

        if person and event
          PersonEvent.create(
            person_id: person.id,
            event_id: event.id
          )
        end

      end
    end

    def _down
      PersonEvent.delete_all
    end

    def satisfied?
      PersonEvent.count > 0
    end

  end
end
