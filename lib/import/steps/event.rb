
module Import
  class Event < Step

    @depends = [EventType]

    def up
      @DB[:event].each do |row|

        @old = row
        @new = ::Event.new

        set_unchanged_cols
        set_dates
        link_type

        @new.save

      end
    end

    #
    # Set directly-migrated column values.
    #
    def set_unchanged_cols
      @new.attributes = {
        legacy_id: @old[:recno],
        name: @old[:label],
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

    #
    # Assign the event to a type.
    #
    def link_type

      type = ::EventType.find_by(name: @old[:type])

      if type
        @new.event_type = type
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
