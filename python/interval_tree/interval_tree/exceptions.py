# coding=utf-8
"""Custom exceptions."""


class NoSuchIntervalError(LookupError):
    """Indicates that no such interval exists in an interval tree."""


class InvalidIntervalError(Exception):
    """Indicates that incorrect values have been assigned to an interval."""
