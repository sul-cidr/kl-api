
require_rel "step"

module Import
  class EventTypeRows < Step

    @depends = []

    def _up
      @DB[:event].distinct(:type).each do |i|
        EventType.create(code: i[:type])
      end
    end

    def _down
      EventType.delete_all
    end

    def satisfied?
      EventType.count > 0
    end

  end
end
