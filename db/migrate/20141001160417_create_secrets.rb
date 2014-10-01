class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.string :movies
      t.string :songs
      t.string :phrases
      t.string :people
      t.string :states
      t.string :code
      t.string :SATVocab

      t.timestamps
    end
  end
end
