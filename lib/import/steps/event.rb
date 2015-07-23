
module Import
  class Event < Step

    @depends = []

    def up
      @DB[:event].each do |row|

        @old = row
        @new = ::Event.create

        set_unchanged_cols
        set_dates

        @new.save

      end
    end

    #
    # Set directly-migrated column values.
    #
    def set_unchanged_cols
      @new.attributes = {
        legacy_id: e[:recno],
        name: e[:label],
      }
    end

    #
    # Set date / year columns.
    #
    def set_dates

      date = @old[:event_date]
      year = @old[:year] || @old[:year_abt] || @old[:year_est]

      if date
        @new.date = date
      elsif year
        @new.year = year
      end

    end

    def down
      ::Event.delete_all
    end

    def satisfied?
      ::Event.count > 0
    end

  end
end
