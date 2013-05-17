# encoding: utf-8
class CreateEditions < ActiveRecord::Migration
  class Edition < ActiveRecord::Base
    attr_accesible :course_id, :location, :active, :start
  end
  def up
    create_table :editions do |t|
      t.date :start
      t.date :finish # pensad por que no lo llamamos 'end'
      t.string :location
      t.boolean :active
      t.integer :seats
      t.integer :price_in_cents # pensad por qué in_cents?
      t.references :course

      t.timestamps
    end

    add_index :editions, :course_id

    # recorre todos los cursos existentes
    Course.all.each do |c|

      # recoge los atributos de los que vamos a quitar las columnas, y la id de curso
      atts = {course_id: c.id, location: c.location,active: c.active, start: c.start_date}

      # crea una edición con los datos recogidos, incluyendo el id de curso
      Edition.create!(atts) # no usamos el belongs_to/has_many aquí
    end

    # Cuando ya está copiada la informacion de curso
    remove_column :courses, :location
    remove_column :courses, :start_date
    remove_column :courses, :active
  end

  def down
    add_column :courses, :location, :string
    add_column :courses, :start_date, :date
    add_column :courses, :active, :boolean
    Course.reset_column_information # para poder acceder a las columnas restauradas

    # Para salvar todos los datos se crean cursos 'gemelos' cuando hay varias ediciones
    # Hay más opciones, como 'unificar' los cursos con mismo nombre y descripción
    Course.all.each do |c|
      first_ed = true
      Edition.where(course_id: c.id).order(:start).each do |e|
        extra = { location: e.location, start_date: e.start, active: e.active }
        if first_ed
          c.update_attributes(extra)
          first_ed = false
        else
          Course.create!(extra.merge( title: c.title,
                                      description: c.description,
                                      created_at: e.created_at,
                                      updated_at: e.updated_at)) # es un hash aunque no lleve '=>'s
        end
      end
    end
    drop_table :editions
  end
end
