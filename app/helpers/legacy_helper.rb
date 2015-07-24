
module LegacyHelper

  #
  # Connect to the legacy database.
  #
  # returns []
  #
  def self.DB

    dbname = Rails.env == "test" ?  "legacy_test" : "legacy"

    # Read KB1 params from Rails config.
    params = Rails.configuration.database_configuration[dbname]

    Sequel.connect(
      :adapter => "postgres",
      **params.symbolize_keys
    )

  end

end
