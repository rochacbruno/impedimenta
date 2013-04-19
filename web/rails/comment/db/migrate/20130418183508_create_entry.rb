class CreateEntry < ActiveRecord::Migration
    def change
        create_table :comment do |table|
            table.primary_key :id
            table.string      :name
            table.string      :message, :null => false, :limit => 500
            table.timestamps
        end
    end
end
