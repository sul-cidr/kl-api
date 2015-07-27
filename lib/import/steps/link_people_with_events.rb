
module Import
  class LinkPeopleWithEvents < Step

    @depends = [CreatePeople, CreateEvents, CreateRoles]

    def up
      @DB[:particip].each do |p|

        # Find matching role.
        role = Role.find_by(name: p[:role])

        # Find matching person.
        person = Person.find_by(legacy_id: p[:actor_id])

        # Find matching event.
        event = Event.find_by(legacy_id: p[:event_id])

        if role and person and event
          PersonEventRel.create(
            role:    role,
            person:  person,
            event:   event,
          )
        end

      end
    end

    def down
      PersonEventRel.delete_all
    end

    def satisfied?
      PersonEventRel.count > 0
    end

  end
end
