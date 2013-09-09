# encoding: utf-8

module CatchFire

  class Evaluator

    attr_reader :context_block

    def initialize(&block)
      @context_block = block
    end

    def run(exception)
      context = CatchFire::Context.new
      context.instance_eval(&@context_block)
      context.evaluate(exception)
    end

  end

end
