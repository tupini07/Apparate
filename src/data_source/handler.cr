require "./db_entry"

module DataSource
  extend self

  def create_db_if_not_exists : Path
    config_dir = Path.home / ".config" / "apparate"

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

    Array(DataSource::DbEntry).from_json content
  end
end
