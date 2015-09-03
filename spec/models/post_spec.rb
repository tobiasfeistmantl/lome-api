require 'rails_helper'

RSpec.describe Post, type: :model do
	
	describe "create new one" do
		before :each do
			@post = FactoryGirl.build(:post)
		end

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

end
