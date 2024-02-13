require "rails_helper"

RSpec.describe Annotator, type: :model do
  it { is_expected.to belong_to(:editor) }
  it { is_expected.to validate_presence_of(:email) }
end
