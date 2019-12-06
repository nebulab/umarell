# frozen_string_literal: true

require 'optparse'

module Umarell
  TOOLS = {
    bundler_audit: 'bundler-audit check --update',
    brakeman: 'brakeman -w2 -q',
    rubocop: 'rubocop',
    reek: 'reek',
    rails_best_practices: 'rails_best_practices',
    fasterer: 'fasterer'
  }.freeze

  # The class responsible of handling command line logic
  class CLI
    def initialize(tools = TOOLS)
      @tools = tools
      @autofix = false
      @args = {}
      @target = ''
    end

    # Entry point to start the application
    def run
      parse_args
      run_commands
    end

    private

    def parse_args
      parse_options
      @target = ARGV.pop
      @args[:rubocop] = ['-a'] if @autofix
    end

    def parse_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: umarell [options] [target]'

        opts.on('-a', '--autofix', 'Autofix violations (if supported)') do
          @autofix = true
        end
        opts.on_tail('-v', '--version', 'Show version') do
          puts Version::STRING
          exit
        end
      end.parse!
    end

    def run_commands
      @tools.each do |name, command|
        run_command(name, command, @args.fetch(name) { [] })
      end
    end

    def run_command(name, command, args)
      header = decorate_message("Running #{name}")
      footer = decorate_message("#{name} run complete\n")
      full_command = "#{command} #{args.join(' ')} #{@target}"

      system "echo '#{header}'; #{full_command}; echo '#{footer}'"
    end

    def decorate_message(string)
      "\e[1;94m~~~~~~~ [Umarell] #{string}\e[0m"
    end
  end
end
