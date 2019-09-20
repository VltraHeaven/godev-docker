FROM fedora:latest

#Install golang
RUN dnf upgrade -y
RUN dnf install -y golang git sudo neovim python{2,3}-neovim
RUN dnf clean all

# Add environment variable to support Go Modules
ENV GO111MODULE=on

# Adding User (with UID and GID of 1000) account with home directory, set working directory.
RUN groupadd -g 1000 golang
RUN useradd -m golang -u 1000 -g 1000 -s /bin/bash
RUN groupadd sudo
RUN echo 'golang ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN usermod -a -G sudo golang
WORKDIR /home/golang
ADD --chown=golang:golang .bashrc /home/golang/
ADD --chown=golang:golang .vimrc /home/golang/
USER golang

# Add 'vim-plug', Vim Plugin Manger
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
 

# Start Container with bash
CMD [ "/bin/bash"]
