require "test_helper"

describe CatchFire do

  class TestCustomError < StandardError; end

  module TestExtension
    def my_custom_case
      exception.message =~ /custom/
    end
  end

  it "Readme example" do

    CatchFire.configure do

      extend TestExtension

      conditions do

        on exception.is_a?(ArgumentError) do
          raise TestCustomError.new(exception)
        end

        on exception.message =~ /weird/ do
          raise TestCustomError.new(exception)
        end

        on my_custom_case do
          raise TestCustomError.new(exception)
        end

      end

    end

    lambda do
      CatchFire.catch_a_fire do
        raise ArgumentError
      end
    end.must_raise(TestCustomError)

    lambda do
      CatchFire.catch_a_fire do
        raise StandardError, "Something smells weird"
      end
    end.must_raise(TestCustomError)

    lambda do
      CatchFire.catch_a_fire do
        raise StandardError, "Test custom case"
      end
    end.must_raise(TestCustomError)

    lambda do
      CatchFire.catch_a_fire do
        Object.new.no_method # raises NoMethodError
      end
    end.must_raise(NoMethodError)

  end

  describe ".configure" do

    it "validates block arg" do
      lambda { CatchFire.configure }.must_raise ArgumentError
    end

    it "creates a evaluator" do
      evaluator = CatchFire.configure do
      end

      evaluator.must_be_instance_of(CatchFire::Evaluator)
    end

  end

  describe ".catch_a_fire" do

    it "execute conditions" do
      evaluator = CatchFire.configure do
        conditions do
          on true do
            throw :owned
          end
        end
      end

      lambda do
        CatchFire.catch_a_fire do
          raise StandardError
        end
      end.must_throw(:owned)
    end

    it "execute conditions by order priority" do
      evaluator = CatchFire.configure do
        conditions do
          on true do
            throw :first
          end
          on true do
            throw :owned
          end
        end
      end

      lambda do
        CatchFire.catch_a_fire do
          raise StandardError
        end
      end.must_throw(:first)
    end

    it "raises original exception by default" do
      CatchFire.configure do
        # nothing
      end
      lambda do
        CatchFire.catch_a_fire do
          raise StandardError
        end
      end.must_raise(StandardError)
    end

  end

end
