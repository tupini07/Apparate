require "./data_source_spec_helper.cr"
require "file_utils"

describe DataSource do
  # TODO: Write tests

  describe "Handler" do
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
      new_entry = DataSource::DbEntry.new name: "test entry",
        path: Path.posix("/tmp"),
        aliases: ["tempy"]

      make_tmp_data_source do |data_source|
        data_source.add_entry_to_db new_entry

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
      raise NotImplementedError.new "a"
    end
  end
end
