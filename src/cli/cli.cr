require "admiral"
require "../common/app_options.cr"

module Cli
  class AddCmd < Admiral::Command
    define_help description: "Adds an entry to record"

    define_flag aliases : Array(String),
      short: 'a',
      description: "The number of times to greet the world"

    def run
      puts "Hello #{flags.aliases || "World"}"
    end
  end

  class ApparateCmd < Admiral::Command
    VERSION = "1.0.0"
    define_version VERSION
    define_help description: "Apparate anywhere in your file system! See documentation for each " \
                             "subcomand."

    register_sub_command add : AddCmd, "Add command"

    def run
      puts "apparate - v#{VERSION}\n\n"
      puts self.help
    end
  end
end
