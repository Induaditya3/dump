# installation

## i3status vanilla config

```css
# i3status configuration file.
# see "man i3status" for documentation.

# It is important that this file is edited as UTF-8.
# The following line should contain a sharp s:
# ß
# If the above line is not correctly displayed, fix your editor first!

general {
        colors = true
        interval = 5
}

# order += "ipv6"
order += "wireless _first_"
order += "ethernet _first_"
order += "battery all"
# order += "disk /"
# order += "load"
order += "cpu_usage"
order += "memory"
order += "tztime local"

wireless _first_ {
        format_up = "W: (%quality at %essid, %bitrate) %ip"
        format_down = "W: down"
}
ethernet _first_ {
        format_up = "E: %ip (%speed)"
        format_down = "E: down"
}

battery all {
        format = "%status %percentage %remaining %emptytime"
        
}

disk "/" {
        format = "Disk: %used/%total (%avail free)"
}

load {
        format = "%1min"
}

memory {
        format = "%used / %available"
        threshold_degraded = "1G"
        format_degraded = "MEMORY < %available"
}

tztime local {
        format = " %B %d  %I:%M %p " 
}

cpu_usage {
         format = "CPU: %usage" 
}
```
## i3status-rust config.toml

```toml
[theme]
theme = "dracula"

[icons]
icons = "material-nf"

[[block]]
block = "custom"
command = "echo \uf011" # assumes fontawesome icons
interval = "once"
[[block.click]]
button = "left"
cmd = "systemctl `echo -e 'suspend\npoweroff\nreboot' | dmenu`"

[[block]]
block = "cpu"
interval = 1
format = " $icon $utilization "

[[block]]
block = "memory"
format = " $icon $mem_used "

[[block]]
block = "net"
device = "wlan0"
format = " $icon $ssid $signal_strength $ip "
interval = 5

[[block]]
block = "sound"
step_width = 5
[[block.click]]
button = "left" 
cmd = "pavucontrol"

[[block]]
block = "battery"
# The update interval in seconds (only affects 'sysfs' and 'apc_ups' drivers)
interval = 10

# Logic Drivers: "sysfs" (direct kernel read, default) or "upower" (standard on GNOME/KDE)
driver = "sysfs"

# Optional: Specify which battery to monitor (e.g., "BAT0", "BAT1"). 
# "DisplayDevice" with UPower merges all batteries into one logical status.
# device = "BAT0"

# --- Formatting ---
# Each state can have its own look. 
# $icon automatically cycles based on percentage if using Nerd Fonts/Font Awesome.
format = " $icon $percentage $time_remaining "
full_format = " $icon Full "              # Shown when battery > full_threshold
charging_format = " $icon $percentage ⚡ " # Shown when power source is plugged in
empty_format = " $icon EMPTY! "           # Shown when battery < empty_threshold
not_charging_format = " $icon AC "        # Shown when plugged in but not charging
missing_format = " No Battery "           # Shown if battery is physically removed

# --- State Thresholds (Determines Color) ---
# Values are percentages. Colors are pulled from your [theme] section.
good = 70       # >= 70%: 'Good' state (usually green)
info = 60       # >= 60%: 'Info' state (usually blue)
warning = 30    # < 30%: 'Warning' state (usually yellow)
critical = 15   # < 15%: 'Critical' state (usually red)

# --- Behavior Thresholds ---
full_threshold = 95    # Consider "Full" even if not 100% (saves battery health)
empty_threshold = 5.0  # Consider "Empty" at 5% to trigger empty_format early



[[block]] 
block = "time" 
interval = 1 
format = " $icon $timestamp.datetime(f:'%a %d %B %I:%M %p') "
```

## two ssh key setup for two different github accounts

- add the first one as usual

- create a new ssh-key and add it to the work GitHub account

`ssh-keygen -t rsa -b 4096 -C "my_work_email@my_company.com"`

- when prompted for filename, save it as *~/.ssh/id_rsa* which is default
 this will create ~/.ssh/id_rsa (private key), ~/.ssh/id_rsa.pub (public key)

- start the agent and add the both keys to the agent
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa          # new key
ssh-add ~/.ssh/id<some_no>    # previous key
```
- add the ssh key to github account

`cat ~/.ssh/id_rsa.pub`

- add following *~/.ssh/config*:

```bash
# Previous account
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id<some_no>
  IdentitiesOnly yes

# new account
Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
  IdentitiesOnly yes

```

- verify

```bash
ssh -T git@github.com
ssh -T git@github.com-work
```

- finally to clone private repo

if repo ssh address is 

> git@github.com:[my work GitHub group]/[my project].git

then
modify it to:

> git@github.com-**work**:[my work GitHub group]/[my project].git

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

## nvm and node.js

install curl first
```
sudo apt update && sudo apt upgrade
sudo apt install curl
```

download and install nvm

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

initialize nvm
```
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```
install node 
```
nvm install --lts
```
set the node version to lts
```
nvm install --lts
```

# updating conda to be compatible with OpenGL

```bash
conda install -c conda-forge compilers
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

variables can be declared simply by using  
`variable_name="some_value"`  
and accessed later anywhere by
`$variable_name`

three things to be careful of    
1. there should be no space between the variable name and = (equal to sign)
2. there should be no space if value to be stored is a literal like string or number and if output of some command is  
3. the output of the some command can be stored inside a variable by enclosing the command inside `$()`. for example `a=$(ls)`

also whatever variable we declare is going to get deleted as soon as we close the terminal and reopen the terminal

there are also lots of pre declared variable called built-in variable or environment variables  
we can see them as by running  `env`  
all of these variables are in all caps to distinguish between the user defined variables  
we can also declare variables in all caps but it is against the best practices
### math functions

to evaluate simple expressions in the bash  
type `expr` followed by the operands and operands with space between them  
example: `expr 5 + 5 \* 2 - 1 / 5 - 1 % 5`  
note that multiplication is specified by `\*`  
`/` does floor division and `%` does modulo operator
we can also use variables like so
```bash
a=75
b=25
expr $a + $b
``` 

### if statements
conditionals
branching

example:
```bash
n=100
if [ $n -eq 100 ]
then
    echo "number is indeed 100 "
fi
```
condition should be inside `[]` and there should be space between opening and closing brackets. condition block is ended using `fi`.

we could also have else blocks like so

```bash
n=1000
if [ $n -eq 100 ]
then
    echo "number is indeed 100 "
else
    echo "number is not 100"
fi
```
we can also negate the condional completely by adding `!` like so 
```bash
n=1000
if [ ! $n -eq 100 ]
then
    echo "number is not 100 "
fi
```
we can also do
```bash
n=1000
if [ $n -ne 100 ]
then
    echo "number is indeed 100 "
fi
```
here `-ne` means "not equal to"
here is a table

| command | meaing                                    |
|:-------:|:------------------------------------------|
| -eq     | equal to                                  |
| -ne     | not equal to                              |
| -gt     | greater than                              |
| -lt     | less than                                 |
| -le     | less than or equal to                     |
| -ge     | greater than or equal to                  |

these are applicable for numbers only and not for string comparisions

one could check existence of file by using
```bash
if [ -f ~/hello.py ]
then
     echo "File exists"
else 
     echo "File  doesn't exist"
fi
```
alternative is 
```bash
fname="hello.py"
fileexists="$(ls $fname)"

if [ "$fname" = "$fileexists" ]
then
   echo "File exists"
else
   echo "File doesn't exist"
fi
```
for checking existence of the directory
```bash
if [ -d ~/dump ]
then 
     echo "Directory exists"
else
     echo "Directory doesn't exist"
fi
```
note `-d` is for directory and `-f` is for file

this can be used for checking existence of the program and install
it if it does not exist
```bash
command=/usr/bin/tldr

if [ -f $command ]
then 
    echo "$command is availble"
else
    echo "$command is not available. Installing it..."
    sudo apt update && sudo apt install -y tldr
fi
```
alternatively we can use `command` or `which`
```bash
command=tldr

if which tldr
then 
     echo "$command does exist."
else
     echo "$command does not exist. Installing it"
     sudo apt update && sudo apt install -y $command
fi
```
and 
```bash
command=tldr

if command -v tldr
then 
     echo "$command does exist."
else
     echo "$command does not exist. Installing it"
     sudo apt update && sudo apt install -y $command
fi
```
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
