import gdb

# Usage: capture <filename> <gdb_command> <args>
class Capture(gdb.Command):
    def __init__(self):
        super(Capture, self).__init__("capture", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        filename, cmd = arg.split(" ", 1)

        gdb.execute(f'call (void) freopen("{filename}", "w", stdout)', to_string=True)
        try:
            gdb.execute(cmd)
            gdb.execute('call (void) fflush(stdout)', to_string=True)
        finally:
            gdb.execute('call (void) freopen("/dev/tty", "w", stdout)', to_string=True)

Capture()
