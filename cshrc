# if cshrc.local exists source that first
if ( -f ~/.cshrc.local ) then
	source ~/.cshrc.local
else
	alias l ls -lrtha
	alias sr screen -r

	alias loc locate -d ~/slocate.db
	set history = 100000
	stty erase '^?'

	# Colors!
	set     red="%{\033[1;31m%}"
	set   green="%{\033[0;32m%}"
	set  yellow="%{\033[1;33m%}"
	set    blue="%{\033[1;34m%}"
	#set magenta="%{\033[1;35m%}"
	#set    cyan="%{\033[1;36m%}"
	#set   white="%{\033[0;37m%}"
	#set     end="%{\033[0m%}" # This is needed at the end... :(

	set ellipsis
	set prompt = "${yellow}%n${blue}@%m ${red}%c03 ${green}$ "

	alias grepall grep -Hrni
endif


