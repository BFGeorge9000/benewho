class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string :first_name
      t.string :last_name
      t.integer :views

      t.timestamps
    end
  end
end
