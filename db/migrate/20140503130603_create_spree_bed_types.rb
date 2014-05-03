class CreateSpreeBedTypes < ActiveRecord::Migration
  def change
    create_table :spree_bed_types do |t|
      t.string :type_id
      t.string :description
      t.references :room_rate_detail, index: true

      t.timestamps
    end
  end
end
