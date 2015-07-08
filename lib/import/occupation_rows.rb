
module Import
  class OccupationRows < Step

    @depends = []

    def _up
      @DB[:indiv_occu].distinct(:occu).each do |i|
        Occupation.create(name: i[:occu])
      end
    end

    def _down
      Occupation.delete_all
    end

    def satisfied?
      Occupation.count > 0
    end

  end
end
