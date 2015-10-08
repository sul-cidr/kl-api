
module Import
  class LinkPeopleWithEvents < Step

    @depends = [CreatePeople, CreateEvents, CreateEventRoles]

    def count
      @DB[:particip].count
    end

    def up
      @DB[:particip].each do |p|

        # Find matching person.
        person = Person.find_by(legacy_id: p[:actor_id])

        # Find matching event.
        event = Event.find_by(legacy_id: p[:event_id])

        # Find matching role.
        role = EventRole.find_by(name: p[:role])

        if person and event and role
          PersonEventRel.create(
            person: person,
            event: event,
            event_role: role,
          )
        end

        increment

      end
    end

    def down
      PersonEventRel.delete_all
    end

  end
end
