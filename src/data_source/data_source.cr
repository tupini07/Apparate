require "./db_entry"

module DB
  class DataSource
    property base_path : Path

    def initialize(@base_path : Path = Path.home)
    end

    def create_db_if_not_exists : Path
      config_dir = self.base_path / ".config" / "apparate"

      # Ensure config dir exists
      Dir.mkdir_p config_dir

      config_dir /= "apparate.json"

      if !File.exists? config_dir
        File.open(config_dir, mode: "w+") do |file|
          File.write file.path, "[]"
        end
      end

      config_dir
    end

    def read_db_data : Array(DbEntry)
      ppath = self.create_db_if_not_exists

      content = File.open(ppath, mode: "r") do |file|
        file.gets_to_end
      end

      Array(DbEntry).from_json content
    end

    private def save_data(data : Array(DbEntry))
      config = self.create_db_if_not_exists
      File.open(config, mode: "w+") do |file|
        File.write file.path, data.to_json
      end
    end

    def add_entry(entry : DbEntry)
      data = self.read_db_data
      data << entry

      self.save_data data
    end

    def rm_entry_with_name(name : String)
      data = self.read_db_data
      entry = data.find { |e| e.name == name }

      raise RuntimeError.new("Entry not found!") if entry.nil?

      data.delete(entry)

      self.save_data data
    end
  end
end
