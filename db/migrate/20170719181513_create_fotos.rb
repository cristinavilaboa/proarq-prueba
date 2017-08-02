class CreateFotos < ActiveRecord::Migration[5.1]
  def change
    create_table :fotos do |t|
      t.string :descripcion
      t.string :src
	  t.string :public_id
      t.references :proyecto, foreign_key: true

      t.timestamps
    end
  end
end
