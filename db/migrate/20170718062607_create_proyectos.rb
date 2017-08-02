class CreateProyectos < ActiveRecord::Migration[5.1]
  def change
    create_table :proyectos do |t|
      t.string :titulo
      t.string :tramite
      t.string :ubicacion
      t.string :descripcion
      t.date :fecha
	  t.string :portada
	  t.string :portada_id
	  
      t.timestamps
    end
  end
end
