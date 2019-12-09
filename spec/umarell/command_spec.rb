# frozen_string_literal: true

describe Umarell::Command do
  it 'creates a full command' do
    command = described_class.new('a_command', ['-opt', 'a_target'])
    allow(command).to receive(:system)

    command.run

    expect(command).to have_received(:system)
      .with(/a_command -opt a_target/)
  end

  it 'adds an header' do
    command = described_class.new('a_command')
    allow(command).to receive(:system)

    command.run

    expect(command).to have_received(:system)
      .with(/\[Umarell\] Running a_command/)
  end

  it 'adds a footer' do
    command = described_class.new('a_command')
    allow(command).to receive(:system)

    command.run

    expect(command).to have_received(:system)
      .with(/\[Umarell\] a_command run complete/)
  end

  it 'runs for real' do
    command = described_class.new('ls', ['README.md'])

    expect { command.run }.to output(/README.md/).to_stdout_from_any_process
  end
end
