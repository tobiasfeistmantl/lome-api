class AddPostingPrivilegeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :posting_privilege, :boolean, default: false, null: false
  end
end
