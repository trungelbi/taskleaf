require 'rails_helper'

describe 'task kanrikikai', type: :system do

	describe 'hyoujikikai' do
		before do
			user_a = FactoryBot.create(:user, name: 'usera', email: 'a@gmail.com')
			FactoryBot.create(:task, name: 'first task', user: user_a)
		end
		context 'dang nhap user a' do
			before do 
				visit login_path
				fill_in 'メールアドレス', with: 'a@gmail.com'
				fill_in 'パスワード', with: 'password'
				click_button 'ログインする'
			end
			it 'task dc tao' do
				expect(page).to have_content 'first task'
			end
		end
	end
end