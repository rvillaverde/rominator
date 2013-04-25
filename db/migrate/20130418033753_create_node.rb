class CreateNode < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :true_path_id
      t.integer :false_path_id
      t.string :value, :limit => 120, :null => false
      t.boolean :index, :default => false
      t.timestamps
    end
  end
end
