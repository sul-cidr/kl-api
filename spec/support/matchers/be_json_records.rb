
#
# Assert that a raw JSON payload corresponds to a set of records.
#
RSpec::Matchers.define :be_json_records do |*expected|
  match do |actual|

    json = JSON.parse(actual)

    e_ids = expected.map{ |e| e.id }
    a_ids = json.map{ |a| a["id"] }
    Set.new(a_ids) == Set.new(e_ids)

  end
end
