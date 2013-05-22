class Item < ActiveRecord::Base
    self.table_name = 'item'
    attr_accessible(:name, :description)

    validates(:name, presence: true)
end
