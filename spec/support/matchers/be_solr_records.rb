
#
# Assert that a search response corresponds to a set of records.
#
RSpec::Matchers.define :be_solr_records do |*expected|
  match do |actual|

    # Get expected IDs.
    e_ids = expected.map{ |e| e.id }

    # Get actual IDs from JSON.
    a_ids = actual.map{ |a| a["result"]["id"] }

    # Should be the same set.
    Set.new(a_ids) == Set.new(e_ids)

  end
end
