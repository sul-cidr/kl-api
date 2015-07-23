
module Import
  class CreatePeople < Step

    @depends = []

    def up
      @DB[:indiv].each do |row|

        @old = row
        @new = Person.new

        set_unchanged_cols
        set_birth_death_dates

        @new.save

      end
    end

    #
    # Set directly-migrated column values.
    #
    def set_unchanged_cols
      @new.attributes = {
        legacy_id:    @old[:indiv_id],
        given_name:   @old[:givn],
        family_name:  @old[:surn],
        sex:          @old[:sex],
      }
    end

    #
    # Map in the birth and death dates.
    #
    def set_birth_death_dates

      # Resolve the birth / death years.
      birth_year = @old[:birthyear] || @old[:birth_abt] || @old[:best]
      death_year = @old[:birthyear] || @old[:birth_abt] || @old[:best]

      # Are the dates exact or approximate?
      birth_est = !!(@old[:birth_abt] || @old[:best])
      death_est = !!(@old[:death_abt] || @old[:dest])

      @new.attributes = {
        birth_year:   birth_year,
        death_year:   death_year,
        birth_est:    birth_est,
        death_est:    death_est,
      }

    end

    def down
      Person.delete_all
    end

    def satisfied?
      Person.count > 0
    end

  end
end
