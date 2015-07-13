
RSpec::Matchers.define :be_records do |*expected|
  match do |actual|

    a_ids = actual.map{ |a| a.id }
    e_ids = expected.map{ |e| e.id }

    Set.new(a_ids) == Set.new(e_ids)

  end
end
