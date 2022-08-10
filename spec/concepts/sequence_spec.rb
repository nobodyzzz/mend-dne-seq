# frozen_string_literal: true

require "rails_helper"


RSpec.describe Sequence do
  describe "#dne?" do
    let(:seq) { [] }
    subject { described_class.new(seq).dne? }

    context "when sequence contains DNE subsequence" do
      let(:seq) { [4, 1, 7, 8, 7, 2] }

      it  { is_expected.to be_truthy }
    end

    context "when sequence doesn't contain DNE subsequence" do
      let(:seq) { [1, 2, 3, 7] }

      it  { is_expected.to be_falsey }
    end
  end
end
