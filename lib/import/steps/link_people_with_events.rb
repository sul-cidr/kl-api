
module Import
  class LinkPeopleWithEvents < Step

    @depends = [CreatePeople, CreateEvents, CreateRoles]

    def up
      @DB[:particip].each do |p|

        role    = Role.find_by(name: p[:role])
        person  = Person.find_by(legacy_id: p[:actor_id])
        event   = Event.find_by(legacy_id: p[:event_id])

        if role and person and event
          PersonEvent.create(
            role:    role,
            person:  person,
            event:   event,
          )
        end

      end
    end

    def down
      PersonEvent.delete_all
    end

    def satisfied?
      PersonEvent.count > 0
    end

  end
end
