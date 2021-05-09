set history save on
set print pretty on
set pagination off
#set confirm off

python
import sys
import os
sys.path.insert(0, os.path.expanduser('~')+'/libcxx-pretty-printers/src')
from libcxx.v1.printers import register_libcxx_printers
register_libcxx_printers (None)
