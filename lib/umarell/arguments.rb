# frozen_string_literal: true

require 'optparse'

module Umarell
  # The class responsible of parsing command line arguments
  class Arguments
    attr_reader :autofix, :target

    alias autofix? autofix

    MODIFIED_FILES_TARGET = '`git ls-files -mo --exclude-standard %s`'

    def initialize
      @autofix = false
      @modified = false
      @target = nil
    end

    # Parse command line arguments
    def parse
      parse_options
      parse_target
    end

    private

    def parse_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: umarell [options] [target]'
        on_autofix(opts)
        on_modified(opts)
        on_version(opts)
      end.parse!
    rescue OptionParser::InvalidOption => e
      exit_with_message("#{e.message}, see 'umarell --help'", 1)
    end

    def parse_target
      last_argument = ARGV.pop
      @target = if @modified
                  MODIFIED_FILES_TARGET % last_argument
                else
                  last_argument
                end
    end

    def on_autofix(opts)
      opts.on('-a', '--autofix', 'Autofix violations (if supported)') do
        @autofix = true
      end
    end

    def on_modified(opts)
      opts.on('-m', '--modified', 'Run on modified files') do
        @modified = true
      end
    end

    def on_version(opts)
      opts.on_tail('-v', '--version', 'Show version') do
        exit_with_message(Version::STRING)
      end
    end

    def exit_with_message(message, code = 0)
      puts "umarell: #{message}"
      exit code
    end
  end
end
