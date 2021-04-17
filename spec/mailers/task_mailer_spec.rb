require 'rails_helper'

describe TaskMailer, type: :mailer do
	let(:task) {FactoryBot.create(:task, name: 'mailer spec', description: 'mail information')}

	let(:text_body) do
		part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
		part.body.raw_source
	end
	let(:html_body) do
		part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
		part.body.raw_source
	end
	describe '#creation_mail' do
		let(:mail) { TaskMailer.creation_email(task)}

		it'check mail' do
			expect(mail.subject).to eq('タスク作成完了メール')
			expect(mail.to).to eq(['user@example.com'])
			expect(mail.from).to eq(['taskleaf@example.com'])

			expect(text_body).to match('以下のタスクを作成しました')
			expect(text_body).to match('mailer spec')
			expect(text_body).to match('mail information')

			expect(html_body).to match('以下のタスクを作成しました')
			expect(html_body).to match('mailer spec')
			expect(html_body).to match('mail information')
		end
	end
end