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

        sudo apt-get dist-upgrade -y;
	check_exit_status

        sudo apt install zsh -y;
        check_exit_status

        sudo apt-get install powerline fonts-powerline -y;
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
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /home/$SUDO_USER/.oh-my-zsh/custom/themes/powerlevel10k
        cp .zshrc /home/$SUDO_USER/.zshrc
        cp .p10k.zsh /home/$SUDO_USER/.p10k.zsh
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
