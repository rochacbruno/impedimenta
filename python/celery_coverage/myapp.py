"""An extremely simple Celery app.

To use, start by ensuring an AMQP broker such as RabbitMQ is running on the
local system. Then, execute the following in a terminal:

.. code-block:: bash

    celery --app myapp --log-level info worker  # window 1

Execute the following in a second terminal:

    python -c 'from myapp import add; add.delay(2, 3)'

"""
from celery import Celery

app = Celery('myapp', broker='amqp://guest@localhost//')


@app.task()
def add(num1, num2):
    """Return the sum of ``num1`` and ``num2``."""
    num1 += 1
    num2 = double(num2)
    return num1 + num2


def double(num):
    """Return ``2 * num``."""
    return 2 * num
