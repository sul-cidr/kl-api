
module Import
  class EventRows < Step

    @depends = []

    def _up
      @DB[:event].each do |e|
        Event.create(
          legacy_id: e[:recno],
          name: e[:label]
        )
      end
    end

    def _down
      Event.delete_all
    end

    def satisfied?
      Event.count > 0
    end

  end
end
