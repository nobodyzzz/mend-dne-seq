require 'rails_helper'

RSpec.describe "Servers", type: :request do
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  context "with correct user input containing DNE sequence" do
    it "returns 200 HTTP status" do
      post "/server", params: { seq: [1, 3, 2, 4] }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  context "with correct user input without DNE sequence in it" do
    it "returns 404 HTTP status" do
      post "/server", params: { seq: [1, 2, 3, 4] }.to_json, headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  shared_examples_for "incorrect input" do |seq, error_message|
    it "returns 422 HTTP status and error message" do
      if seq
        post "/server", params: { seq: seq }.to_json, headers: headers
      else
        post "/server", headers: headers
      end

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include(error_message)
    end
  end

  context "when user provided too short sequence" do
    it_behaves_like "incorrect input", [1, 2],"size cannot be less than"
  end

  context "when user provided too long sequence" do
    it_behaves_like "incorrect input", [1]*(Sequence::MAX_LENGTH + 1), "size cannot be greater than"
  end

  context "when user provided non-integer element in sequence" do
    it_behaves_like "incorrect input", [1, 2, 3, "string"], "must be an integer"
  end

  context "when user provided too small element in sequence" do
    it_behaves_like "incorrect input", [1, 2, 3, Sequence::MIN_VALUE - 1], "must be greater than"
  end

  context "when user provided too large element in sequence" do
    it_behaves_like "incorrect input", [1, 2, 3, Sequence::MAX_VALUE + 1], "must be less than"
  end
  
  context "when user provided no input" do
    it_behaves_like "incorrect input", nil, "is missing"
  end
end
