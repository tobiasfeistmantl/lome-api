require 'rails_helper'

RSpec.describe User, type: :model do
	subject { build(:user) }

	it { is_expected.to be_valid }

	it { is_expected.to have_secure_password }
	it { is_expected.to validate_length_of(:firstname).is_at_most(15) }
	it { is_expected.to validate_length_of(:lastname).is_at_most(25) }
	it { is_expected.to validate_length_of(:password).is_at_least(7) }
	it { is_expected.to validate_presence_of :username }
	it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
	it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

	it { is_expected.to have_db_index(:username) }
	it { is_expected.to have_db_index(:email) }

	it { is_expected.to allow_value(FFaker::Internet.email).for(:email) }
	it { is_expected.to_not allow_value('invalid@@email.com').for(:email) }
	it { is_expected.to_not allow_value('invalid@email..com').for(:email) }

	it { is_expected.to have_many(:sessions).dependent(:destroy) }
	it { is_expected.to have_many(:positions).dependent(:destroy) }
	it { is_expected.to have_many(:active_relationships).dependent(:destroy) }
	it { is_expected.to have_many(:follower) }
	it { is_expected.to have_many(:passive_relationships).dependent(:destroy) }
	it { is_expected.to have_many(:following) }
	it { is_expected.to have_many(:posts).dependent(:destroy) }
	it { is_expected.to have_many(:liked_posts) }


	context "with firstname validation" do
		before { allow(subject).to receive(:lastname?) { true } }
		it { is_expected.to validate_presence_of(:firstname).with_message("can't be blank if Lastname is set") }
	end

	context "with lastname validation" do
		before { allow(subject).to receive(:firstname?) { true } }
		it { is_expected.to validate_presence_of(:lastname).with_message("can't be blank if Firstname is set") }
	end

	it "returns nil for full name because of missing first and lastname" do
		subject.firstname = nil
		subject.lastname = nil
		expect(subject.name).to be_nil
	end

	it "returns the full name as string" do
		expect(subject.name).to eq("#{subject.firstname} #{subject.lastname}")
	end

	it "is an email with all lowercased letters" do
		subject.email.upcase!
		subject.valid?
		expect(subject.email).to eq(subject.email.downcase)
	end
end






