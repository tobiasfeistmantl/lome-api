require 'rails_helper'

RSpec.describe PostAbuseReport, type: :model do
	subject { build :post_abuse_report }

	it { is_expected.to be_valid }

	it { is_expected.to belong_to(:reporter).class_name('User') }
	it { is_expected.to belong_to(:post) }
end
