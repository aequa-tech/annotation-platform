require "rails_helper"

RSpec.describe Taxonomy, type: :model do
  it { is_expected.to belong_to(:editor) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:editor_id) }
  it { is_expected.to validate_uniqueness_of(:title).scoped_to(:editor_id) }
end
