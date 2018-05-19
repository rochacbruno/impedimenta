picocom
=======

Install picocom.

Installing this application makes the "uucp" group available.

Splitting this task out into a separate role is useful for user creation roles.
Such roles can list this one as a dependency, thus ensuring that the "uucp"
group is available before the user is created. That said, there may be a more
elegant way of satisfying this need.
