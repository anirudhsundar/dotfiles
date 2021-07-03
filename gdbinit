set history save on
set print pretty on
set pagination off
source ~/local.gdbinit
#set confirm off

# source TVM specific scripts
source ~/.gdb/tvm/gdbinit

python
import sys
import os
base_gdb_path = os.path.expanduser('~')+'/.gdb'
sys.path.insert(0, base_gdb_path+'/libcxx-pretty-printers/src')
from libcxx.v1.printers import register_libcxx_printers
register_libcxx_printers (None)

