class CreateSpreeSmokingPreferences < ActiveRecord::Migration
  def change
    create_table :spree_smoking_preferences do |t|
      t.string :value
      t.references :room_rate_detail, index: true

      t.timestamps
    end
  end
end
