class CreateTrains < ActiveRecord::Migration
  def change
    create_table(:lines) do |t|
      t.column(:name, :string)

      t.timestamps
    end

    create_table(:stations) do |t|
      t.column(:name, :string)

      t.timestamps
    end

    create_table(:lines_stations) do |t|
      t.column(:line_id, :integer)
      t.column(:station_id, :integer)

      t.timestamps
    end
  end
end
