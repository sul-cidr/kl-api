
module Import
  class LandmarkRows < Step

    @depends = []

    def up
      @DB[:place].where(admin2: "London").each do |p|
        Landmark.create(name: p[:dbname])
      end
    end

    def down
      Landmark.delete_all
    end

    def satisfied?
      Landmark.count > 0
    end

  end
end
