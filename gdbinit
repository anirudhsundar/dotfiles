set history save on
set print pretty on
set pagination off
set breakpoint pending on
source ~/local.gdbinit
#set confirm off

# source TVM specific scripts
source ~/tvm-gdb-commands/commands.py
alias tvd = tvm_dump
alias tvt = tvm_type
alias tvat = tvm_attr
alias tvf = tvm_fields

python
import sys
import os
base_gdb_path = os.path.expanduser('~')+'/.gdb'
sys.path.insert(0, base_gdb_path+'/libcxx-pretty-printers/src')
from libcxx.v1.printers import register_libcxx_printers
register_libcxx_printers (None)

