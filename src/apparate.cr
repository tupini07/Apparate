require "./data_source/handler"
require "json"

# TODO: Write documentation for `Apparate`
module Apparate
  VERSION = "0.1.0"

  data = DataSource.read_db_data

  puts data
end
