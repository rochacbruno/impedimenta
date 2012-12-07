#!/usr/bin/env ruby

require 'test/unit'
require 'functions'

# Unit tests for the methods in module +functions+.
class TestFunctions < Test::Unit::TestCase
    # Unit tests for the +sort_string+ function.
    def test_sort_string
        assert_equal '1 22 333', sort_string('1 22 333')
        assert_equal '1 22 333', sort_string('333 22 1')
        assert_equal 'o tw thr', sort_string('o tw thr')
        assert_equal 'o tw thr', sort_string('thr tw o')
    end

    # Unit tests for the +sort_string_2+ function.
    def test_sort_string_2
        assert_equal '1 22 333', sort_string_2('1 22 333')
        assert_equal '1 22 333', sort_string_2('333 22 1')
        assert_equal 'o tw thr', sort_string_2('o tw thr')
        assert_equal 'o tw thr', sort_string_2('thr tw o')
    end
end
