set history save on
set print pretty on
set pagination off
set breakpoint pending on
source ~/local.gdbinit
#set confirm off

# source TVM specific scripts
source ~/.gdb/tvm-gdb-commands/commands.py

python
import sys
import os
base_gdb_path = os.path.expanduser('~')+'/.gdb'
sys.path.insert(0, base_gdb_path+'/libcxx-pretty-printers/src')
from libcxx.v1.printers import register_libcxx_printers
register_libcxx_printers (None)
end

# std::string pretty printer causes issues sometimes. Enable again to try out
# if needed
disable pretty-printer global libc;std::basic_string
