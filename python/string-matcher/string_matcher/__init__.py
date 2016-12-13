# coding=utf-8
"""The root of the ``string_matcher`` namespace."""


def kmp_matcher(text, pattern):
    """Find the positions at which ``pattern`` is present in ``text``.

    Return an iterable of zero-based indices indicating where ``pattern``
    occurs in ``text. Implemented with the Knuth-Morris-Pratt algorithm.
    """
    indices = []
    prefix_func = compute_prefix_function(pattern)
    chars_matched = 0
    for i, char in enumerate(text):
        while chars_matched > 0 and pattern[chars_matched] != char:
            chars_matched = prefix_func[chars_matched - 1] + 1
        if pattern[chars_matched] == char:
            chars_matched += 1
        if chars_matched == len(pattern):
            indices.append(i - len(pattern) + 1)
            chars_matched = prefix_func[chars_matched - 1] + 1
    return indices


def compute_prefix_function(pattern):
    """Compute the prefix function used by :func:`kmp_matcher`."""
    prefix_func = [-1 for _ in range(len(pattern))]
    k = -1
    # `i` is used to walk through each character in `pattern` and
    # `prefix_func`. For example, given 'ababaca', i ranges from 1 to 6.
    # prefix_func[0] is always given a value of -1, and prefix_func[1..6] are
    # computed.
    #
    # `k` determines the value placed in each element of prefix_func.
    for i in range(1, len(pattern)):
        while k >= 0 and pattern[k + 1] != pattern[i]:
            k = prefix_func[k]
        if pattern[k + 1] == pattern[i]:
            k += 1
        prefix_func[i] = k
    return prefix_func
