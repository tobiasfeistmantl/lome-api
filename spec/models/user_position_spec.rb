require 'rails_helper'

RSpec.describe UserPosition, type: :model do
	subject { build(:user_position) }
	
	it { is_expected.to be_valid }

	it { is_expected.to belong_to :session }
	it { is_expected.to validate_presence_of :session }
	it { is_expected.to validate_presence_of :latitude }
	it { is_expected.to validate_presence_of :longitude }
end
