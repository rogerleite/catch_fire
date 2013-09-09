require "test_helper"

describe CatchFire::Context do

  subject { CatchFire::Context.new }

  describe "#load_conditions!" do

    let(:exception) { StandardError.new("mock") }

    it "load conditions block" do
      subject.conditions do
        on true do
          "block ok"
        end
      end
      subject.load_conditions!(exception)
      subject._conditions_chain.wont_be_empty
      subject._conditions_chain.first.call.must_equal("block ok")
    end

    it "load conditions block with exception available" do
      subject.conditions do
        on(exception.is_a?(StandardError)) do
          exception
        end
      end
      subject.load_conditions!(exception)
      subject._conditions_chain.wont_be_empty
      subject._conditions_chain.first.call.must_equal(exception)
    end

  end

  describe "#evaluate" do

    subject do
      ctx = CatchFire::Context.new
      ctx.conditions do
        on exception.message =~ /test/ do
          raise ArgumentError.new(exception.message, exception)
        end
      end
      ctx
    end

    it "evals conditions" do
      ex = StandardError.new("test exception")
      lambda do
        subject.evaluate(ex)
      end.must_raise(ArgumentError)
    end

    it "raises original exception" do
      ex = StandardError.new("exception")
      lambda do
        subject.evaluate(ex)
      end.must_raise(StandardError)
    end

  end

end
