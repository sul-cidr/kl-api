
module Import
  class PersonRows < Step

    @depends = []

    def up
      @DB[:indiv].each do |i|
        Person.create(
          legacy_id:    i[:indiv_id],
          given_name:   i[:givn],
          family_name:  i[:surn],
          sex:          i[:sex],
          religion:     i[:reli],
        )
      end
    end

    def down
      Person.delete_all
    end

    def satisfied?
      Person.count > 0
    end

  end
end
