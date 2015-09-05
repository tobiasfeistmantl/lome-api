require 'rails_helper'

RSpec.describe Relationship, type: :model do
	subject { build(:relationship) }
	
	it { is_expected.to be_valid }

	it { is_expected.to belong_to :follower }
	it { is_expected.to belong_to :followed }

	it { is_expected.to validate_presence_of :follower }
	it { is_expected.to validate_presence_of :followed }
end
