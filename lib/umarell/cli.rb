# frozen_string_literal: true

require_relative 'arguments'
require_relative 'command'

module Umarell
  TOOLS = {
    'bundler-audit' => ['check', '--update'],
    'brakeman' => ['-w2', '-q', '--no-pager', '--no-summary'],
    'rubocop' => [],
    'erblint' => [],
    'reek' => [],
    'rails_best_practices': [],
    'fasterer' => []
  }.freeze

  AUTOFIX_SUPPORT = %w[rubocop erblint].freeze

  # The class responsible of handling command line logic
  class CLI
    def initialize(tools = TOOLS, arguments = Arguments.new)
      @tools = tools
      @arguments = arguments
    end

    # Entry point to start the application
    def run
      @arguments.parse
      run_commands
    end

    private

    def run_commands
      @tools.each do |name, options|
        arguments = command_arguments(name, options)
        Command.new(name, arguments).run
      end
    end

    def command_arguments(name, options)
      command_arguments = command_options(name, options)
      return command_arguments unless @arguments.target

      command_arguments + [@arguments.target]
    end

    def command_options(name, base_options)
      return base_options unless AUTOFIX_SUPPORT.include?(name)

      base_options + ['-a']
    end
  end
end
