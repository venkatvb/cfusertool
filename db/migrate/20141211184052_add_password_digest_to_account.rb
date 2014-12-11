class AddPasswordDigestToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :password_digest, :string
  end
end
