
module Import
  class CreateEventTypes < Step

    @depends = []

    def up
      @DB[:event].distinct(:type).each do |i|
        EventType.create(name: i[:type])
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
