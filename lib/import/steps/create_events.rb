
module Import
  class CreateEvents < Step

    @depends = [CreateEventTypes]

    def up
      @DB[:event].each do |row|

        @old = row
        @new = Event.new

        set_unchanged_cols
        set_dates
        set_event_type
        set_address

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
    def set_event_type

      type = EventType.find_by(name: @old[:type])

      if type
        @new.event_type = type
      end

    end

    #
    # Try to find an address for the event.
    #
    def set_address

      # Try to find a matching place.
      place = @DB[:place].where(placeid: @old[:place_id]).first

      if place
        @new.address = place[:dbname]
      end

    end

    def down
      Event.delete_all
    end

    def satisfied?
      Event.count > 0
    end

  end
end
