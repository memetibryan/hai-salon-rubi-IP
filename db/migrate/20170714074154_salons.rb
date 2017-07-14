class Salons < ActiveRecord::Migration[5.1]
  def change
  	create_table(:salons) do |s|
        s.column(:name, :string)

        s.timestamps()
    end
  end
end