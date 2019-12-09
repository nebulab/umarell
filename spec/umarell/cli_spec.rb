# frozen_string_literal: true

describe Umarell::CLI do
  it 'calls commands with arguments' do
    arguments = instance_spy(Umarell::Arguments, target: 'a_target')
    command = instance_spy(Umarell::Command)
    tools = { 'a_command' => ['-opt'] }
    cli = described_class.new(tools, arguments)
    allow(Umarell::Command).to receive(:new)
      .with('a_command', ['-opt', 'a_target'])
      .and_return(command)

    cli.run

    expect(arguments).to have_received(:parse)
    expect(command).to have_received(:run)
  end

  it 'calls supported tools with autofix option' do
    arguments = instance_spy(Umarell::Arguments, target: nil, autofix?: true)
    command = instance_spy(Umarell::Command)
    tools = { 'rubocop' => [] }
    cli = described_class.new(tools, arguments)
    allow(Umarell::Command).to receive(:new)
      .with('rubocop', ['-a'])
      .and_return(command)

    cli.run

    expect(arguments).to have_received(:parse)
    expect(command).to have_received(:run)
  end
end
