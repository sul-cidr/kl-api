
module Import
  class EventDates < Step

    @depends = [EventRows]

    def _up
      @DB[:event].each do |e|

        event = Event.find_by(legacy_id: e[:recno])

        date = e[:event_date]
        year = e[:year] || e[:year_abt] || e[:year_est]

        if date
          event.update(year: date.year)
        elsif year
          event.update(year: year)
        end

      end
    end

    def _down
      Event.update_all(
        year: nil,
        year_est: nil
      )
    end

    def satisfied?
      Event.where.not(year: nil).exists?
    end

  end
end
