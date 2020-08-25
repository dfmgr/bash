## bash  
  
Bash is the GNU Project's shell  
  
requires:

```shell
apt install bash bash-completion direnv
```  

```shell
yum install bash bash-completion direnv
```  

```shell
pacman -S bash bash-completion direnv
```  

```shell
xbps-install -S bash bash-completion direnv
```

```shell
brew install bash bash-completion direnv
```

Automatic install/update:

```shell
bash -c "$(curl -LSs https://github.com/dfmgr/bash/raw/master/install.sh)"
```

Manual install:

```shell
mv -fv "$HOME/.config/bash" "$HOME/.config/bash.bak"
git clone https://github.com/dfmgr/bash "$HOME/.config/bash"
ln -sf $HOME/.config/bash/.bash* "$HOME/"
```
  
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/bash" target="_blank">bash wiki</a>  |  
  <a href="https://www.gnu.org/software/bash/" target="_blank">bash site</a>
</p>  
