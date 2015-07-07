
require_rel "step"

module Import
  class EventRows < Step

    @depends = []

    def _up
      @DB[:event].each do |e|

        # Find a matching person row.
        person = Person.find_by(legacy_id: e[:indiv_id])

        if person
          Event.create(
            legacy_id: e[:recno],
            person_id: person.id,
            name: e[:label]
          )
        end

      end
    end

    def _down
      Event.delete_all
    end

    def satisfied?
      Event.count > 0
    end

  end
end
