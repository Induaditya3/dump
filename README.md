# installation

## latex
```
sudo apt install texlive-latex-base texlive-latex-recommended texlive-fonts-recommended texlive-latex-extra
sudo apt install texlive-science
sudo apt install latexmk

pacman -Qs texlive
```

on cachyos, install bauh first
then from there install above package

## miscellaneous utilities
**wallpaper** / **wall paper**
```
sudo apt install variety
sudo pacman -S variety
```

to make its menu  dark theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

**safe eyes**
```
sudo add-apt-repository ppa:safeeyes-team/safeeyes

sudo apt install safeeyes
```
## r
```
sudo pacman -S r
```
 **rstudio**
```
yay -S rstudio-desktop-bin
```
# os
## to turn off showing boot menu while booting os

```
sudo nano /boot/loader/loader.conf
sudo ls /boot/loader/loader.conf
ls /boot/loader/loader.conf
sudo bootctl set-default linux-cachyos.conf
sudo bootctl list
bootctl list
```

make the content of loader.conf as

```
default @saved
timeout 0
console-mode keep
```

# system administration
sysadmin
system management
automation

## bash scripting

### hello world

find the shell which you are running

`echo $SHELL`

to find the path of the bash if it is intalled

`which bash`

to turn the script into a executable

for example file bash script saved as myscript.sh 

but note that file name could be anythind does not need to end .sh

`sudo chmod +x myscript.sh`

sudo is not always necessary

to force system to use bash interpreter  
we use prepend following shebang to every bash script  
`#!/bin/bash`
### variables

### math functions

### if statements
condionals
branching

### exit codes

### while loops
iteration

### universal update scripts

### for loops
iteration

### filesystem locations for scripts

### data streams

### functions

### case statements

### scheduling jobs

### arguments

### creating a backup script