Basic Pulp Performance Testing
==============================

This directory contains some *extremely* basic Pulp performance tests. The goal
is to measure how long it takes to perform several actions. There is inevitably
some variation in how long it takes to perform each action, so each individual
action is performed numerous times, so as to swamp small variations. For
comparison, think of `python -m timeit`.

The same actions can then be done on some product that uses Pulp, such as
Katello. The time necessary to complete step 1, 2, 3, etc. can be compared on
Pulp and the other product.

Sample usage:

```sh
./setup.sh
time ./test-01.sh
time ./test-02.sh
time ./test-03.sh
./teardown.sh
```

It would be better to write scripts that directly communicated with Pulp's API.
This is for two reasons:

* Applications such as Katello use Pulp's API, not `pulp-admin`. (Right?!)
* Using the API allows for greater control over Pulp's behaviour. Note, for
  example, that the `setup.sh` script publishes the repsitory that it creates
  and syncs, and this is unnecessary.
