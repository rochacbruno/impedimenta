class CreateItem < ActiveRecord::Migration
    def change
        create_table(:item) do |table|
            table.string(:name)
            table.string(:description)
            table.timestamps
        end
    end
end
