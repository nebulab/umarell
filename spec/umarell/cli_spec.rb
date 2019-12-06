# frozen_string_literal: true

describe Umarell::CLI do
  it 'runs a command on a target' do
    cli = described_class.new(ls: 'ls')
    ARGV.replace(['README.md'])

    expect { cli.run }.to output(/README.md/).to_stdout_from_any_process
  end

  it 'runs all configured tools' do
    cli = described_class.new
    allow(cli).to receive(:system)
    ARGV.replace([])

    cli.run

    expect(cli).to have_received(:system).with(/bundler-audit/)
    expect(cli).to have_received(:system).with(/brakeman/)
    expect(cli).to have_received(:system).with(/rubocop/)
    expect(cli).to have_received(:system).with(/reek/)
    expect(cli).to have_received(:system).with(/rails_best_practices/)
    expect(cli).to have_received(:system).with(/fasterer/)
  end

  it 'supports autofix option' do
    cli = described_class.new
    allow(cli).to receive(:system)
    ARGV.replace(['-a'])

    cli.run

    expect(cli).to have_received(:system).at_least(:once)
    expect(cli).to have_received(:system).with(/rubocop -a/)
  end
end
