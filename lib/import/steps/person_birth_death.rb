
module Import
  class PersonBirthDeath < Step

    @depends = [PersonRows]

    def up
      @DB[:indiv].each do |i|

        birth_year = i[:birthyear] || i[:birth_abt] || i[:best]
        death_year = i[:deathyear] || i[:death_abt] || i[:dest]

        birth_circa = i[:birth_abt] || i[:best]
        death_circa = i[:birth_abt] || i[:best]

        Person.find_by(legacy_id: i[:indiv_id]).update(
          birth_year: birth_year,
          death_year: death_year,
          birth_est:  !!birth_circa,
          death_est:  !!death_circa
        )

      end
    end

    def down
      Person.update_all(
        birth_year: nil,
        death_year: nil,
        birth_est: nil,
        death_est: nil
      )
    end

    def satisfied?
      Person.where.not(birth_year: nil).exists?
    end

  end
end
