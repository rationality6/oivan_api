class AddTableQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :user
      t.references :test
      t.string :name, comment: 'name of question'
      t.string :description, comment: 'description of question'
      t.timestamps
    end
  end
end
