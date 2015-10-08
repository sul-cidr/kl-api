
module Import
  class CreateOccupations < Step

    @depends = []

    def up
      @DB[:indiv_occu].distinct(:occu).each do |i|
        Occupation.create(name: i[:occu])
      end
    end

    def down
      Occupation.delete_all
    end

    def satisfied?
      Occupation.count > 0
    end

  end
end
