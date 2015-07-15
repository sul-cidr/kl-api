
#
# Assert that a raw JSON payload corresponds to a set of records.
#
RSpec::Matchers.define :be_json_records do |*expected|
  match do |actual|

    json = JSON.parse(actual)

    # Get expected IDs.
    e_ids = expected.map{ |e| e.id }

    # Get actual IDs from JSON.
    a_ids = json.map{ |a| a["id"] }

    # Should be the same set.
    Set.new(a_ids) == Set.new(e_ids)

  end
end
