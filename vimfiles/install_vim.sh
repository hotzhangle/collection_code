#!/usr/bin/env bash

cmd_env='unix'
function update_vim(){
	sudo add-apt-repository ppa:jonathonf/vim
	sudo apt update
	sudo apt install vim
}

function uninstall_vim() {
	sudo apt remove vim
	sudo add-apt-repository --remove ppa:jonathonf/vim
}

function install_plug_vim() {
	#ensure curl command exists.
	command -v curl >/dev/null 2>&1 || { echo >&2 "I require curl but it's not installed.  Aborting."; exit 1; }
	if [[ 1 -eq `command -v curl` ]]; then
		#statements
	fi
	if [[ cmd_env == "unix" ]];then
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	elif [[ cmd_env == "powershell" ]]; then
		# md ~\vimfiles\autoload
		# $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		# (New-Object Net.WebClient).DownloadFile(
		#   $uri,
		#   $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
		#     "~\vimfiles\autoload\plug.vim"
		#   )
		# )
	fi
}

function create_plug_rc (){
	#https://github.com/junegunn/vim-plug
	touch ~/.vim/vim-plug.vim
	cat << EOF >> ~/.vim/vim-plug.vim
	call plug#begin()
	Plug 'tpope/vim-sensible'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	call plug#end()
	EOF
}
