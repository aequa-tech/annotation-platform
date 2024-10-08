require "rails_helper"

RSpec.describe Corpus, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to belong_to(:editor) }
end
