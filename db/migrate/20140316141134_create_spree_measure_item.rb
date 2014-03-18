class CreateSpreeMeasureItem < ActiveRecord::Migration
  def change
    create_table :spree_measure_items do |t|
      t.references :measurement_set
      t.references :measure
      t.decimal    :value, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.timestamps  
    end
  end
end
