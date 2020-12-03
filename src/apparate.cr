require "./data_source/data_source.cr"
require "./cli/cli.cr"
require "json"

# TODO: Write documentation for `Apparate`
module Apparate
  # VERSION = "0.1.0"

  # ds = DB::DataSource.new
  # data = ds.read_db_data

  # puts data

  Cli::ApparateCmd.run
end
