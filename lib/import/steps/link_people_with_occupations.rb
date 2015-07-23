
module Import
  class LinkPeopleWithOccupations < Step

    @depends = [CreatePeople, CreateOccupations]

    def up
      @DB[:indiv_occu].each do |i|

        # Find matching person.
        person = Person.find_by(legacy_id: i[:indiv_id])

        # Find matching occupation.
        occupation = Occupation.find_by(name: i[:occu])

        # Link person -> occupation.
        if person and occupation
          PersonOccupation.create(
            person: person,
            occupation: occupation
          )
        end

      end
    end

    def down
      PersonOccupation.delete_all
    end

    def satisfied?
      PersonOccupation.count > 0
    end

  end
end
