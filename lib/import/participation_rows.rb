
require_rel "step"

module Import
  class ParticipationRows < Step

    @depends = [PersonRows, EventRows]

    def _up
      @DB[:particip].each do |p|

        person = Person.find_by(legacy_id: p[:actor_id])
        event = Event.find_by(legacy_id: p[:event_id])

        if person and event
          Participation.create(
            person_id: person.id,
            event_id: event.id
          )
        end

      end
    end

    def _down
      Participation.delete_all
    end

    def satisfied?
      Participation.count > 0
    end

  end
end
