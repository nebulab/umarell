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
      parse_options
      create_args
      run_commands
    end

    private

    def parse_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: umarell [options] [target]'

        opts.on('-a', '--autofix', 'Autofix violations (if supported)') do
          @autofix = true
        end
      end.parse!

      @target = ARGV.pop
    end

    def create_args
      @args[:rubocop] = ['-a'] if @autofix
    end

    def run_commands
      @tools.each do |name, command|
        run_command(name, command, @args.fetch(name) { [] })
      end
    end

    def run_command(name, command, args)
      message = "\n\e[35m[Umarell] Running #{name}...\e[0m"
      system "echo '#{message}'; #{command} #{args.join(' ')} #{@target}"
    end
  end
end
