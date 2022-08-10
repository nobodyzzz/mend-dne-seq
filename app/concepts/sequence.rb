# frozen_string_literal: true

class Sequence
  MIN_VALUE = -2 ** 10
  MAX_VALUE = 2 ** 10
  MAX_LENGTH = 2 ** 10
  MIN_LENGTH = 3

  attr_reader :nums

  def initialize(nums)
    @nums = nums
  end

  def dne?
    return false unless nums.length >= MIN_LENGTH

    stack = []
    ak = MIN_VALUE - 1

    nums.reverse_each do |ai|
      return true if ai < ak

      ak = stack.pop while stack.any? && stack.last < ai

      stack.push(ai)
    end

    false
  end
end
