require "./data_source_spec_helper.cr"
require "file_utils"

describe DB::DataSource do
  it "creates folder to place config if it does not exist" do
    make_tmp_data_source do |data_source|
      dbFile = data_source.create_db_if_not_exists
      (File.exists? dbFile).should eq true
    end
  end

  it "correctly loads an empty array when config does not exist" do
    make_tmp_data_source do |data_source|
      data = data_source.read_db_data
      data.empty?.should eq true
    end
  end

  it "correctly saves new entries into the DB" do
    new_entry = DB::DbEntry.new name: "test entry",
      path: Path.posix("/tmp"),
      aliases: ["tempy"]

    make_tmp_data_source do |data_source|
      data_source.add_entry new_entry

      data = data_source.read_db_data
      res = data.find { |e| e.name == new_entry.name }
      res.nil?.should eq false

      if !res.nil?
        res.name.should eq new_entry.name
        res.path.should eq new_entry.path
        res.aliases.should eq new_entry.aliases
      end
    end
  end

  it "correctly removes an entry from the DB" do
    make_tmp_data_source do |data_source|
      new_entry = DB::DbEntry.new name: "test221 entry",
        path: Path.posix(Path.home),
        aliases: ["sweet_home"]

      data_source.add_entry new_entry

      data_source.rm_entry_with_name new_entry.name

      data = data_source.read_db_data
      res = data.find { |e| e.name == new_entry.name }
      res.nil?.should eq true
    end
  end

  it "remove raises error if entry does not exist" do
    make_tmp_data_source do |data_source|
      expect_raises(RuntimeError, "Entry not found!") do
        data_source.rm_entry_with_name "unexistent name"
      end
    end
  end

end
