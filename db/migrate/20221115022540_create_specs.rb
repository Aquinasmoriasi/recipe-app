class CreateSpecs < ActiveRecord::Migration[7.0]
  def change
    create_table :specs do |t|

      t.timestamps
    end
  end
end
