class AddDenylistTable < ActiveRecord::Migration[6.0]
  def change
    create_table :jwt_denylists do |t|
      t.string :jti, null: false, default: ''
      t.datetime :exp, null: false
      t.references :user
      t.timestamps
    end

    add_index :jwt_denylists, :jti
  end
end

