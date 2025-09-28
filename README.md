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
```
a=75
b=25
expr $a + $b
``` 

### if statements
conditionals
branching

example:
```n=100
if [ $n -eq 100 ]
then
    echo "number is indeed 100 "
fi
```
condition should be inside `[]` and there should be space between opening and closing brackets. condition block is ended using `fi`.

we could also have else blocks like so

```
n=1000
if [ $n -eq 100 ]
then
    echo "number is indeed 100 "
else
    echo "number is not 100"
fi
```
we can also negate the condional completely by adding `!` like so 
```
n=1000
if [ ! $n -eq 100 ]
then
    echo "number is not 100 "
fi
```
we can also do
```
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
```
if [ -f ~/hello.py ]
then
     echo "File exists"
else 
     echo "File  doesn't exist"
fi
```
alternative is 
```
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
```
if [ -d ~/dump ]
then 
     echo "Directory exists"
else
     echo "Directory doesn't exist"
fi
```
note `-d` is for directory and `-f` is for file

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