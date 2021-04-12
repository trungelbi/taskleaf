require 'rails_helper'

describe 'task kanrikikai', type: :system do
	let!(:user_a) { FactoryBot.create(:user, name: 'usera', email: 'a@gmail.com')}
	let(:user_b) { FactoryBot.create(:user, name: 'userb', email: 'b@gmail.com')}
	let!(:task_a) { FactoryBot.create(:task, name: 'first task', user: user_a) }

	before do
		visit login_path
		fill_in 'メールアドレス', with: login_user.email
		fill_in 'パスワード', with: login_user.password
		click_button 'ログインする'
	end
	describe 'hyoujikikai' do
		context 'dang nhap user a' do
			let(:login_user) {user_a}
			it 'task user a dc tao' do
				expect(page).to have_content 'first task'
			end
		end
		context 'dang nhap user b' do
			let(:login_user) {user_b}
			it 'task user a do not show' do
				expect(page).to have_no_content 'first task'
			end
		end
	end
	describe '詳細表示機械' do
		context 'login user a' do
			let(:login_user) {user_a}		
			before do
				visit task_path(task_a)

			end
			it 'task user a show' do
				expect(page).to have_content 'first task'
			end
		end
	end
end