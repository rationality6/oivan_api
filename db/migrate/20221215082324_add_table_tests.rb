class AddTableTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.references :user
      t.string :name, comment: 'name of test'
      t.string :description, comment: 'description of test'
      t.timestamps
    end
  end
end
