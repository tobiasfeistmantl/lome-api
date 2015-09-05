require 'rails_helper'

RSpec.describe UserSession, type: :model do
  subject { build(:user_session) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :token }

  it { is_expected.to have_many(:positions).dependent(:destroy) }
  it { is_expected.to belong_to :user }

  it "generates a session token" do
    subject.generate_token
    expect(subject.token).to_not be_nil
  end
end
