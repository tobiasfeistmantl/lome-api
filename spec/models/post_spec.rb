require 'rails_helper'

RSpec.describe Post, type: :model do

	before :each do
		@post = FactoryGirl.build(:post)
	end
	
	describe "create new one" do

		context "with valid data" do
			it "with every possible attribute" do
				expect(@post).to be_valid
				expect(@post.image.class).to be PostImageUploader
			end
		
			it "without a message but with image" do
				@post.message = nil

				expect(@post).to be_valid
				expect(@post.image.class).to be PostImageUploader
				expect(@post.message).to be_nil
			end

			it "without image but with a message" do
				@post = FactoryGirl.build(:post, image: nil)

				expect(@post).to be_valid
				expect(@post.image.url).to be_nil
				expect(@post.message).to_not be_nil
			end
		end

		context "with invalid data" do
			it "without both message and image" do
				@post = FactoryGirl.build(:post, message: nil, image: nil)

				expect(@post).to be_invalid
			end
		end

	end

	it "is not raising an error on associations" do
		expect { @post.likes }.not_to raise_error
		expect(@post.likes.class).to be Like::ActiveRecord_Associations_CollectionProxy

	end

end
