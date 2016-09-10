# coding=utf-8
"""Algorithms for finding the maximum subarray in an iterable of integers.

Each algorithm has the same signature:

``integers``
    An iterable of integers.
``start``
    The lower index of where to search in ``integers``. If not given, assumed
    to be 0.
``end``
    The upper index of where to search in ``integers``. If not given, assumed
    to be ``len(integers) - 1``.

The return value is the maximum subarray of ``indices``, as a
``max_sub.MaxSub`` object.
"""
from collections import namedtuple

MaxSub = namedtuple('MaxSub', ('start', 'end', 'sum'))
"""A maximum subarray.

``start`` and ``end`` are indices into an iterable, and ``sum`` is the sum of
the given range (inclusive of the bounds).
"""


def brute_force(integers, start=None, end=None):
    """Find the maximum subarray within the ``integers`` array.

    An n^2 algorithm is used.
    """
    if start is None:
        start = 0
    if end is None:
        end = len(integers) - 1
    best_start = None
    best_end = None
    best_sum = None
    for curr_start in range(start, end + 1):
        for curr_end in range(curr_start, end + 1):
            # NOTE: Despite the shallow copies, this is faster than:
            #
            #     sum_ = sum((integers[i] for i in range(start, end + 1)))
            #
            sum_ = sum(integers[curr_start:curr_end + 1])
            if best_sum is None or sum_ > best_sum:
                best_sum = sum_
                best_start = curr_start
                best_end = curr_end
    return MaxSub(best_start, best_end, best_sum)


def recursive(integers, start=None, end=None):
    """Find the maximum subarray within the ``integers`` array.

    A recursive algorithm is used.
    """
    if start is None:
        start = 0
    if end is None:
        end = len(integers) - 1

    # The base case is when one element is considered.
    if start >= end:
        return MaxSub(start, start, integers[start])

    # The recursive case is when two or more elements are considered. If
    # exactly two elements are considered, indices are calculated like so:
    #
    #     ┌─────┬─────┐
    #     │  a  │  b  │
    #     └─────┴─────┘
    #     ↑     ↑
    #     start middle
    #           end
    #
    middle = start + ((end - start) // 2) + 1
    start_max_sub = recursive(integers, start, middle - 1)
    middle_max_sub = _middle_subarray(integers, start, middle, end)
    end_max_sub = recursive(integers, middle, end)
    if (start_max_sub.sum >= middle_max_sub.sum and
            start_max_sub.sum >= end_max_sub.sum):
        return start_max_sub
    elif (middle_max_sub.sum >= start_max_sub.sum and
          middle_max_sub.sum >= end_max_sub.sum):
        return middle_max_sub
    else:
        return end_max_sub


def _middle_subarray(integers, start, middle, end):
    """Find the maximum subarray within the ``integers`` array.

    Only subarrays that lie within the bounds of ``start`` and ``end``, and
    that touch ``middle`` are considered. Return a ``MaxSub``.

    ``integers`` must have two or more elements. In the case that ``integers``
    has only two elements, ``middle`` is assumed to have a value of 1. This
    makes sense if one thinks about the index ``middle`` as being a zero-width
    divider marking the beginning of each array item::

        ┌───┬───┐
        │ a │ b │
        └───┴───┘
        ↑   ↑
        0   1
    """
    # NOTE: This algorithm is adapted almost verbiatm from the book.
    left_i = None
    left_sum = None
    right_i = None
    right_sum = None

    sum_ = 0
    for i in range(middle - 1, start - 1, -1):
        sum_ += integers[i]
        if left_sum is None or sum_ > left_sum:
            left_sum = sum_
            left_i = i

    sum_ = 0
    for i in range(middle, end + 1):
        sum_ += integers[i]
        if right_sum is None or sum_ > right_sum:
            right_sum = sum_
            right_i = i

    return MaxSub(left_i, right_i, left_sum + right_sum)


def hybrid(integers, start=None, end=None):
    """Find the maximum subarray within the ``integers`` array.

    A hybrid of the recursive and brute force algorithms is used.
    """
    if start is None:
        start = 0
    if end is None:
        end = len(integers) - 1

    # The base case is handled by brute_force().
    if end - start < 10:
        return brute_force(integers, start, end)

    # The recursive case is when two or more elements are considered. If
    # exactly two elements are considered, indices are calculated like so:
    #
    #     ┌─────┬─────┐
    #     │  a  │  b  │
    #     └─────┴─────┘
    #     ↑     ↑
    #     start middle
    #           end
    #
    middle = start + ((end - start) // 2) + 1
    start_max_sub = recursive(integers, start, middle - 1)
    middle_max_sub = _middle_subarray(integers, start, middle, end)
    end_max_sub = recursive(integers, middle, end)
    if (start_max_sub.sum >= middle_max_sub.sum and
            start_max_sub.sum >= end_max_sub.sum):
        return start_max_sub
    elif (middle_max_sub.sum >= start_max_sub.sum and
          middle_max_sub.sum >= end_max_sub.sum):
        return middle_max_sub
    else:
        return end_max_sub
