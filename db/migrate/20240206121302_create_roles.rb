class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.integer "movie_id" #foreign key
      t.integer "actor_id" #foreign key
      t.string "character_name"
      t.timestamps
    end
  end
end
