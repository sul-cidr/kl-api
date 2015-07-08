
module Import
  class OccupationLinks < Step

    @depends = [OccupationRows]

    def _up
      @DB[:indiv_occu].each do |i|

        # Find a matching person / occupation.
        occupation = Occupation.find_by(name: i[:occu])
        person = Person.find_by(legacy_id: i[:indiv_id])

        # Link person -> occupation.
        if occupation and person
          PersonOccupation.create(
            occupation_id: occupation.id,
            person_id: person.id
          )
        end

      end
    end

    def _down
      PersonOccupation.delete_all
    end

    def satisfied?
      PersonOccupation.count > 0
    end

  end
end
