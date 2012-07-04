#!/usr/bin/env python
"""
Example of how to use the tasks module written by Forest Bond.
"""

from tasks import (
    Task,
    ComplexTask,
)
import time

class CustomTask(Task):
    """It is extremely common to subclass Task objects in Logistix."""
    def do_run(self):
        for status in ('staring', 'working', 'ending',):
            yield [self.change('status', status)]
            time.sleep(0.1)
# The method self.finish() does not exist, despite what the doucmentation
# claims.
#        try:
#            yield self.finish()
#        except:
#            yield self.fail('method self.finish() does not exist')

my_task = CustomTask('the_task')
manager = ComplexTask(
    'the manager',
    [
        CustomTask('first worker'),
        CustomTask('second worker'),
        CustomTask('third worker'),
    ],
)

print "Demonstrating how to use a simple task."
for task_changes in my_task.run():
    for task_change in task_changes:
        print "Task <{0}> parameter <{1}> changing: <{2}> -> <{3}>".format(
            task_change.task,
            task_change.parameter,
            task_change.oldvalue,
            task_change.value
        )
print ""
print "Demonstrating how to use a complex task."
for task_changes in manager.run():
    for task_change in task_changes:
        print "Task <{0}> parameter <{1}> changing: <{2}> -> <{3}>".format(
            task_change.task,
            task_change.parameter,
            task_change.oldvalue,
            task_change.value
        )
