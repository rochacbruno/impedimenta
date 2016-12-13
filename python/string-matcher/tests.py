# coding=utf-8
"""Unit tests for this application."""
import unittest

from string_matcher import compute_prefix_function, kmp_matcher


class KmpMatcherTestCase(unittest.TestCase):
    """Test :func:`string_matcher.kmp_matcher`."""

    @classmethod
    def setUpClass(cls):
        """Provide a consistent pattern for each test."""
        cls.pattern = 'ababaca'

    def test_text_missing_pattern(self):
        """Search through a string for which no match is present."""
        indices = kmp_matcher('aabababacbx', self.pattern)
        self.assertEqual(indices, [])

    def test_text_like_pattern(self):
        """Search through a string exactly like the search pattern."""
        indices = kmp_matcher(self.pattern, self.pattern)
        self.assertEqual(indices, [0])

    def test_text_has_prefix(self):
        """Search through a string like the search pattern w/a prefix.

        e.g. if the search pattern is 'abc', then the text may be 'aabc'.
        """
        indices = kmp_matcher('a' + self.pattern, self.pattern)
        self.assertEqual(indices, [1])

    def test_text_has_pattern(self):
        """Search through a string for which a match is present."""
        indices = kmp_matcher('aabababacax', self.pattern)
        self.assertEqual(indices, [3])

    def test_text_has_patterns(self):
        """Search through a string for which matches are present."""
        indices = kmp_matcher('ababacababaca', self.pattern)
        self.assertEqual(indices, [0, 6])


class ComputePrefixFunctionTestCase(unittest.TestCase):
    """Test :func:`string_matcher.compute_prefix_function`."""

    def test(self):
        """Test :func:`string_matcher.compute_prefix_function`.

        The "prefix function" returned by
        :func:`string_matcher.compute_prefix_funtion` is nothing more than an
        array of indices. As the KMP matcher algorithm proceeds, the following
        question frequently arises: "Given that n characters have matched the
        pattern and the next character does not match the pattern, how far back
        in the pattern should I walk to check for a new match?" The indices in
        the prefix function answer that question. For example::

            indices       0   1  2  3  4   5  6
            pattern       a   b  a  b  a   c  a
            prefix-func  -1  -1  0  1  2  -1  0
        """
        prefix_func = compute_prefix_function('ababaca')
        self.assertEqual(prefix_func, [-1, -1, 0, 1, 2, -1, 0])
