
#
# Assert that expected and actual records have the same ids.
#
RSpec::Matchers.define :be_records do |*expected|
  match do |actual|

    # Get expected IDs.
    e_ids = expected.map{ |e| e.id }

    # Get actual IDs.
    a_ids = actual.map{ |a| a.id }

    # Should be the same set.
    Set.new(a_ids) == Set.new(e_ids)

  end
end
