
module Import
  class PersonEventRows < Step

    @depends = [Person, Event, RoleRows]

    def up
      @DB[:particip].each do |p|

        role    = Role.find_by(name: p[:role])
        person  = Person.find_by(legacy_id: p[:actor_id])
        event   = Event.find_by(legacy_id: p[:event_id])

        if person and event
          PersonEvent.create(
            role_id:    role.id,
            person_id:  person.id,
            event_id:   event.id,
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
