#!/usr/bin/env python
"""Example of how to use the tasks module written by Forest Bond."""

import tasks, time

class CustomTask(tasks.Task):
    """A simple task that yields three states before ending."""

    def do_run(self):
        for status in ('staring', 'working', 'ending',):
            yield [self.change('status', status)]
            time.sleep(0.1)
        try:
            yield self.complete()
        except tasks.NewInstructionError as err:
            print("Task failed to complete: {}".format(err.message))
            yield self.fail('method self.complete() does not exist')

def main():
    """The one and only main function."""

    print "Demonstrating how to use a simple task."
    for task_changes in CustomTask('my simple task').run():
        for task_change in task_changes:
            print "Task <{0}> parameter <{1}> changing: <{2}> -> <{3}>".format(
                task_change.task,
                task_change.parameter,
                task_change.oldvalue,
                task_change.value
            )
    print ""

    print "Demonstrating how to use a complex task."
    manager = tasks.ComplexTask(
        'my complex task',
        [
            CustomTask('first worker'),
            CustomTask('second worker'),
            CustomTask('third worker'),
        ],
    )
    for task_changes in manager.run():
        for task_change in task_changes:
            print "Task <{0}> parameter <{1}> changing: <{2}> -> <{3}>".format(
                task_change.task,
                task_change.parameter,
                task_change.oldvalue,
                task_change.value
            )

if '__main__' == __name__:
    main()
