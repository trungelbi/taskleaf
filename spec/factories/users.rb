FactoryBot.define do
	factory :user do
		name { 'testuser'}
		email { 'user@example.com'}
		password { 'password'}
	end
end