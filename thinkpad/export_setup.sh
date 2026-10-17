
# Package lists
pacman -Qqen > pkglist-native.txt     # explicitly installed, official repos
pacman -Qqem > pkglist-aur.txt        # AUR/foreign packages

# Enabled services
systemctl list-unit-files --state=enabled > services.txt
systemctl --user list-unit-files --state=enabled > services-user.txt
