class AddTableOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.references :user
      t.references :question
      t.boolean :answer, comment: 'anwser'
      t.string :description, comment: 'description of question'
      t.timestamps
    end
  end
end
