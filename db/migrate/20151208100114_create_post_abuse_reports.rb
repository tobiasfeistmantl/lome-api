class CreatePostAbuseReports < ActiveRecord::Migration
	def change
		create_table :post_abuse_reports do |t|
			t.references :reporter, index: true
			t.references :post, index: true, foreign_key: true

			t.timestamps null: false
		end
		add_foreign_key :post_abuse_reports, :users, column: :reporter_id
	end
end
