# encoding: utf-8

module CatchFire

  class Context

    attr_reader :exception

    def initialize
      @conditions_block = nil
      @conditions_chain = []
    end

    def conditions(&block)
      @conditions_block = block
    end

    def _conditions_chain
      @conditions_chain
    end

    def load_conditions!(exception)
      @exception = exception
      if @conditions_block
        self.instance_eval(&@conditions_block)
      end
    end

    def on(expression, &block)
      @conditions_chain.push(block) if expression
    end

    def evaluate(exception)
      self.load_conditions!(exception)
      if self._conditions_chain.empty?
        raise exception
      else
        self._conditions_chain.first.call
      end
    end

  end

end
