require 'rails_helper'

RSpec.describe Post, type: :model do
	before(:each) do
		@post = FactoryGirl.build(:post)
	end

	it "should be a valid post" do
		expect(@post.valid?).to be true
		expect(@post.image.class).to be PostImageUploader
	end

	it "should be a valid post without message but with image" do
		@post.message = nil

		expect(@post.valid?).to be true
		expect(@post.image.class).to be PostImageUploader
		expect(@post.message).to be_nil
	end

	it "should be a valid post without image but with a message" do
		@post = FactoryGirl.build(:post, image: nil)

		expect(@post.valid?).to be true
		expect(@post.image.url).to be_nil
		expect(@post.message).to_not be_nil
	end

	it "should not be valid without both message and image" do
		@post = FactoryGirl.build(:post, message: nil, image: nil)

		expect(@post.valid?).to be false
	end
end
