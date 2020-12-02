require "spec"
require "../../src/data_source/data_source.cr"

# Creates a tmp directory and creates a new DataSource instance with this dir and calls the passed
# block with this DataSource instance as a parameter
def make_tmp_data_source(&block)
  ran_name = ('a'..'z').to_a.sample(16).join("")

  temp_path = (Path.new Dir.tempdir) / ran_name

  (Dir.exists? temp_path).should eq false
  Dir.mkdir_p temp_path

  data_source = DataSource::DataSource.new temp_path

  yield data_source

  FileUtils.rm_r temp_path.to_s
  (Dir.exists? temp_path).should eq false
end
