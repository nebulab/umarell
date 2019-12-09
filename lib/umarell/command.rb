# frozen_string_literal: true

module Umarell
  # The class responsible for running commands
  class Command
    def initialize(name, arguments = [])
      @name = name
      @arguments = arguments
    end

    # Run the command
    def run
      system "echo '#{header}'; #{self}; echo '#{footer}'"
    end

    def to_s
      "#{@name} #{@arguments.join(' ')}"
    end

    private

    def header
      decorate_message("Running #{@name}")
    end

    def footer
      decorate_message("#{@name} run complete\n")
    end

    def decorate_message(string)
      "\e[1;94m~~~~~~~ [Umarell] #{string}\e[0m"
    end
  end
end
