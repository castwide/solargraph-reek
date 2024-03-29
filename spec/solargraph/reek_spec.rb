RSpec.describe Solargraph::Reek do
  it 'returns code smells' do
    source = Solargraph::Source.load('spec/fixtures/dirty.rb')
    reporter = Solargraph::Reek::Reporter.new()
    errors = reporter.diagnose(source, nil)
    expect(errors).not_to be_empty
  end
end
