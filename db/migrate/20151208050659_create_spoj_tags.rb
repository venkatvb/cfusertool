class CreateSpojTags < ActiveRecord::Migration
  def change
    create_table :spoj_tags do |t|
      t.string :tagName

      t.timestamps
    end
  end
end
