FactoryGirl.define do
  factory :post do
    message "MyText"
	latitude 47.358500
	longitude 11.703402
	association :author, factory: :user
	image { File.open("#{ENV["HOME"]}/Developer/web/test/test-image.jpeg") }
  end

end
