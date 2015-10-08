
module Import
  class CreateEventTypes < Step

    def up
      @DB[:event].distinct(:type).each do |i|
        EventType.create(name: i[:type])
      end
    end

    def down
      EventType.delete_all
    end

  end
end
