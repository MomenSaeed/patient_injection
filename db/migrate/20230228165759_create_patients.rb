class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :full_name
      t.string :api_key

      t.timestamps
    end
  end
end
