import gdb

class TVMDump(gdb.Command):
    """Call tvm::Dump on the passed argument for easy printing"""

    def __init__(self):
        super(TVMDump, self).__init__(
            "td", gdb.COMMAND_USER
        )

    def invoke(self, args, from_tty):
        arg_list = gdb.string_to_argv(args)
        for arg in arg_list:
            gdb.execute('print tvm::Dump('+arg+')')

    def complete(self, text, word):
        return gdb.COMPLETE_SYMBOL


TVMDump()

