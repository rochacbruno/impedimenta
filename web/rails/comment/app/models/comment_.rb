# This class is used to access the +comment+ database table. Unfortunately,
# +Comment+ is already used by rails itself in the +config/application.rb+ file.
class Comment_ < ActiveRecord::Base
    self.table_name = 'comment'
    self.primary_key = 'id'

    attr_accessible(:name, :message)
end
