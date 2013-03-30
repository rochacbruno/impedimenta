#!/usr/bin/env ruby

# "This will automatically discover your Gemfile, and make all of the gems in
# your Gemfile available to Ruby." http://gembundler.com/v1.3/rationale.html
require 'rubygems'
require 'bundler/setup'

require 'test/unit'
require_relative 'functions'

# Fails?!
#puts "Unit testing with test-unit v#{Test::Unit::VERSION}"

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
