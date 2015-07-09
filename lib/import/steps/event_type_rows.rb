
module Import
  class EventTypeRows < Step

    @depends = []

    def up
      @DB[:event].distinct(:type).each do |i|
        EventType.create(code: i[:type])
      end
    end

    def down
      EventType.delete_all
    end

    def satisfied?
      EventType.count > 0
    end

  end
end
