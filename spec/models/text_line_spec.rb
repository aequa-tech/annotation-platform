require "rails_helper"

RSpec.describe TextLine, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:corpus) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:content) }
  end
end
