require "rails_helper"

RSpec.describe Patient do
  describe "Associations" do
    it { is_expected.to have_many(:injections) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:api_key) }
    it { is_expected.to validate_uniqueness_of(:api_key) }
    it { is_expected.to validate_presence_of(:full_name) }
  end
end

