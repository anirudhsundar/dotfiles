#!/bin/bash

# ARG_POSITIONAL_SINGLE([output-dir],[Path to clone the stdman repo])
# ARG_OPTIONAL_SINGLE([install-dir],[],[Install directory name to be appended to output-dir],[install_dir])
# ARG_OPTIONAL_SINGLE([man-path],[],[Path to file where MANPATH env should be added],["$HOME/.local_paths"])
# ARG_HELP([Clone and setup man pages for cppreference of libstdc++ from stdman repo])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='h'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_install_dir="install_dir"
_arg_man_path="$HOME/.local_paths"


print_help()
{
	printf '%s\n' "Clone and setup man pages for cppreference of libstdc++ from stdman repo"
	printf 'Usage: %s [--install-dir <arg>] [--man-path <arg>] [-h|--help] <output-dir>\n' "$0"
	printf '\t%s\n' "<output-dir>: Path to clone the stdman repo"
	printf '\t%s\n' "--install-dir: Install directory name to be appended to output-dir (default: 'install_dir')"
	printf '\t%s\n' "--man-path: Path to file where MANPATH env should be added (default: '"$HOME/.local_paths"')"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			--install-dir)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_install_dir="$2"
				shift
				;;
			--install-dir=*)
				_arg_install_dir="${_key##--install-dir=}"
				;;
			--man-path)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_man_path="$2"
				shift
				;;
			--man-path=*)
				_arg_man_path="${_key##--man-path=}"
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


handle_passed_args_count()
{
	local _required_args_string="'output-dir'"
	test "${_positionals_count}" -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 1 (namely: $_required_args_string), but got only ${_positionals_count}." 1
	test "${_positionals_count}" -le 1 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 1 (namely: $_required_args_string), but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_output_dir "

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash

MANPATH_BASE="/usr/local/man:/usr/local/share/man:/usr/share/man:/usr/man"
STDMAN_URL="https://github.com/jeaye/stdman.git"

STDMAN_PATH="$_arg_output_dir"
STDMAN_INSTALL_PATH="${STDMAN_PATH}/$_arg_install_dir"

echo "output-dir: $_arg_output_dir"
echo "install-dir: $_arg_install_dir"
echo "install-full-path: $STDMAN_INSTALL_PATH"

MANPATH_VAL="${MANPATH_BASE}:${STDMAN_INSTALL_PATH}/share/man"
echo "manpath: $MANPATH_VAL"

echo "man-path file: $_arg_man_path"


git clone $STDMAN_URL $STDMAN_PATH
$STDMAN_PATH/configure --prefix="$STDMAN_PATH/install_dir"
make -C ${STDMAN_PATH} install

echo "export MANPATH=${MANPATH_VAL}" >> "$HOME/.local_manpath"
echo "source $HOME/.local_manpath" >> "$_arg_man_path"
# ] <-- needed because of Argbash
