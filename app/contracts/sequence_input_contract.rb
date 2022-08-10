# frozen_string_literal: true

class SequenceInputContract < Dry::Validation::Contract
  params do
    required(:seq)
      .filled(:array, min_size?: Sequence::MIN_LENGTH, max_size?: Sequence::MAX_LENGTH)
      .each(:int?)
      .each(gt?: Sequence::MIN_VALUE)
      .each(lt?: Sequence::MAX_VALUE)
  end
end
