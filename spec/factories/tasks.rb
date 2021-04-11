FactoryBot.define do
	factory :task do
		name { 'test' }
		description { 'rspec & capybara & factory test'}
		user
	end
end