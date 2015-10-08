
module Import
  class CreateOccupations < Step

    def up
      @DB[:indiv_occu].distinct(:occu).each do |i|
        Occupation.create(name: i[:occu])
      end
    end

    def down
      Occupation.delete_all
    end

  end
end
