# coding=utf-8
import os

from buildbot.master import BuildMaster
from twisted.application import service
from twisted.python.log import ILogObserver, FileLogObserver
from twisted.python.logfile import LogFile


basedir = os.path.abspath(os.path.dirname(__file__))
rotateLength = 10000000
maxRotatedFiles = 10

# note: this line is matched against to check that this is a buildmaster
# directory; do not edit it.
application = service.Application('buildmaster')
logfile = LogFile.fromFullPath(
    os.path.join(basedir, "twistd.log"),
    rotateLength=rotateLength,
    maxRotatedFiles=maxRotatedFiles,
)
application.setComponent(ILogObserver, FileLogObserver(logfile).emit)

build_master = BuildMaster(basedir, 'master.cfg', None)
build_master.setServiceParent(application)
build_master.log_rotation.rotateLength = rotateLength
build_master.log_rotation.maxRotatedFiles = maxRotatedFiles

# vim: set ft=python et:
