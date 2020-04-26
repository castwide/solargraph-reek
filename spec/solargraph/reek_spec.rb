RSpec.describe Solargraph::Reek do
  it 'returns code smells' do
    source = Solargraph::Source.load_string(%(
      class Dirty
        def m(a,b,c)
          puts a,b
        end
      end
    ))
    reporter = Solargraph::Reek::Reporter.new()
    errors = reporter.diagnose(source, nil)
    expect(errors).not_to be_empty
  end
end
