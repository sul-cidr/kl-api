
#
# Assert that expected and actual records have the same ids.
#
RSpec::Matchers.define :be_records do |*expected|
  match do |actual|
    e_ids = expected.map{ |e| e.id }
    a_ids = actual.map{ |a| a.id }
    Set.new(a_ids) == Set.new(e_ids)
  end
end
