# frozen_string_literal: true

describe Umarell::Arguments do
  subject(:arguments) { described_class.new }

  before do
    allow(arguments).to receive(:exit)
  end

  it 'parses target if present' do
    ARGV.replace(['a_target'])

    arguments.parse

    expect(arguments.target).to eq('a_target')
    expect(arguments).not_to have_received(:exit)
  end

  it 'returns error if option not supported' do
    ARGV.replace(['-unsupported_option'])

    expect { arguments.parse }.to output(/invalid option/).to_stdout
    expect(arguments).to have_received(:exit).with(1)
  end

  it 'parses autofix option' do
    ARGV.replace(['-a'])

    arguments.parse

    expect(arguments.autofix?).to be_truthy
    expect(arguments).not_to have_received(:exit)
  end

  it 'parses modified option' do
    ARGV.replace(['-m', 'a_target'])

    arguments.parse

    expect(arguments.target).to match(/git ls-files .* a_target/)
    expect(arguments).not_to have_received(:exit)
  end
end
