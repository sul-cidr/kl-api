
module Import
  class CreateEventRoles < Step

    def up
      @DB[:particip].distinct(:role).each do |r|
        EventRole.create(name: r[:role])
      end
    end

    def down
      EventRole.delete_all
    end

  end
end
