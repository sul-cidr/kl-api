
module Import
  class LinkPeopleWithOccupations < Step

    @depends = [CreatePeople, CreateOccupations]

    def up
      @DB[:indiv_occu].each do |i|

        # Find matching person.
        person = Person.find_by(legacy_id: i[:indiv_id])

        # Find matching occupation.
        occupation = Occupation.find_by(name: i[:occu])

        if person and occupation
          PersonOccupationRel.create(
            person: person,
            occupation: occupation
          )
        end

      end
    end

    def down
      PersonOccupationRel.delete_all
    end

  end
end
