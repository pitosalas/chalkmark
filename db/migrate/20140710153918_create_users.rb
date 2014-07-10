class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :ip
      t.string :email
      t.string :guid

      t.timestamps
    end
  end
end
