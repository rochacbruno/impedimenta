require 'test_helper'

class ItemTest < ActiveSupport::TestCase
    def test_disallow_empty_item
        assert !Item.new({}).valid?
    end

    def test_allow_name_only
        assert Item.new({name: 'foo'}).valid?
    end

    def test_disallow_description_only
        assert !Item.new({description: 'bar'}).valid?
    end

    def test_allow_name_and_description
        assert Item.new({name: 'foo', description: 'bar'}).valid?
    end
end
