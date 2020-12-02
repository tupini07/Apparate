require "json"

module DB
  class DbEntry
    include JSON::Serializable

    property name : String
    property path : Path
    property aliases : Array(String)

    def initialize(@name, @path, @aliases = [] of String)
    end

    def to_s(io)
      io << "<#{self.class.name} name='#{self.name}' path='#{self.path}' n_aliases='#{self.aliases.size}'>"
    end
  end
end
