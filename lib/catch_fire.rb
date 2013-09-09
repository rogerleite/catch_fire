# encoding: utf-8
require "catch_fire/version"
require "catch_fire/context"
require "catch_fire/evaluator"

module CatchFire

  def self.configure(&block)
    raise ArgumentError, "Context block is required." unless block_given?
    @evaluator = Evaluator.new(&block)
  end

  def self.catch_a_fire(&block)
    begin
      block.call
    rescue Exception => exception
      @evaluator.run(exception)
    end
  end

end
