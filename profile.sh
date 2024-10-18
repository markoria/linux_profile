#!/bin/bash

check_exit_status() {

	if [ $? -eq 0 ]
	then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Process Failed!"
		echo
		read -p "The last command exited with an error. Exit script? (yes/no) " answer

            if [ "$answer" == "yes" ]
            then
                exit 1
            fi
	fi
}

greeting() {

	echo
	echo "Hello, $SUDO_USER. Let's update this system and install zsh."
	echo
}

update() {

        sudo apt-get update;
	    check_exit_status

        sudo apt-get upgrade -y;
	    check_exit_status

        sudo apt install zsh bat -y;
        check_exit_status
        if [ -d "/home/$SUDO_USER/.oh-my-zsh" ]; then
			echo "oh-my-zsh already installed"
		else
		    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		    check_exit_status
			echo "oh-my-zsh not installed"
		fi

        sh -c "$(curl -s https://ohmyposh.dev/install.sh | bash -s)"
        check_exit_status
}

housekeeping() {

	sudo apt-get autoremove -y;
	check_exit_status

	sudo apt-get autoclean -y;
	check_exit_status
}

copyingfiles() {
        git clone https://github.com/robbyrussell/oh-my-zsh.git /home/$SUDO_USER/.oh-my-zsh
	    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
	    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	    git clone https://github.com/zsh-users/you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
	    git clone https://github.com/zsh-users/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat

        dir=~/linux_profile                    # dotfiles directory
		olddir=~/dotfiles_old             # old dotfiles backup directory
		files="vimrc vim zshrc template.toml"    # list of files/folders to symlink in homedir

		##########

		# create dotfiles_old in homedir
		echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
		mkdir -p $olddir
		echo "done"

		# change to the dotfiles directory
		echo -n "Changing to the $dir directory ..."
		cd $dir
		echo "done"

		# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
		for file in $files; do
			echo "Moving any existing dotfiles from ~ to $olddir"
			mv ~/.$file ~/dotfiles_old/
			echo "Creating symlink to $file in home directory."
			ln -s $dir/$file ~/.$file
		done
		}

setdefaultshell() {
        chsh -s /bin/zsh
        zsh
}

leave() {

	echo
	echo "--------------------"
	echo "- Update Complete! and install complete -"
	echo "--------------------"
	echo
	exit
}

greeting
update
housekeeping
copyingfiles
setdefaultshell
leave
