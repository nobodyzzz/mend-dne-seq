class ServerController < ApplicationController
  def create
    render json: result, status: status
  end

  private

  def user_input
    ::SequenceInputContract.new.call(params.to_unsafe_h)
  end

  def dne_sequence_present?
    Sequence.new(user_input[:seq]).dne?
  end
  
  def status
    return :unprocessable_entity unless user_input.errors.empty?

    dne_sequence_present? ? :ok : :not_found
  end

  def result
    user_input.errors.empty? ? { result: dne_sequence_present? } : { errors: user_input.errors.to_h }
  end
end
