
require_rel "step"

module Import
  class EventDates < Step

    @depends = [EventRows]

    def _up
      @DB[:event].each do |e|

        event = Event.find_by(legacy_id: e[:recno])

        if e[:event_date]
          event.update(date: e[:event_date])
        else
          year = e[:year] || e[:year_abt] || e[:year_est]
          event.update(year: year)
        end

      end
    end

    def _down
      Event.update_all(
        date: nil,
        year: nil
      )
    end

    def satisfied?
      Event.where.not(date: nil).exists?
    end

  end
end
