
module Import
  class RoleRows < Step

    @depends = []

    def up
      @DB[:particip].distinct(:role).each do |r|
        Role.create(name: r[:role])
      end
    end

    def down
      Role.delete_all
    end

    def satisfied?
      Role.count > 0
    end

  end
end
