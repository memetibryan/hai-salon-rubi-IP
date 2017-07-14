class Clients < ActiveRecord::Migration[5.1]
  def change
    create_table(:clients) do |t|
        t.column(:description, :string)
        t.column(:salon_id, :integer)

        t.timestamps()
    end
  end
end