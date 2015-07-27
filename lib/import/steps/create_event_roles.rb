
module Import
  class CreateEventRoles < Step

    @depends = []

    def up
      @DB[:particip].distinct(:role).each do |r|
        EventRole.create(name: r[:role])
      end
    end

    def down
      EventRole.delete_all
    end

    def satisfied?
      EventRole.count > 0
    end

  end
end
