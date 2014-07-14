class CreateHelpfuls < ActiveRecord::Migration
  def change
    create_table :helpfuls do |t|
      t.references :user, index: true
      t.string :url
      t.boolean :value
      t.timestamps
    end
  end
end
