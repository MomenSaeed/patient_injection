require "rails_helper"

RSpec.describe Injection do
  describe "Associations" do
    it { is_expected.to belong_to(:patient) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:dose) }
    it { is_expected.to validate_presence_of(:drug_name) }
    it { is_expected.to validate_presence_of(:lot_number) }
    it { is_expected.to validate_length_of(:lot_number).is_equal_to(6) }
    it { is_expected.to allow_value("test12").for(:lot_number) }
    it { is_expected.not_to allow_value("test$1").for(:lot_number) }
  end
end

