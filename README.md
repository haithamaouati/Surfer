# Ꞩurfer
The **Ꞩurfer** app allows you to browse the list of packages available in the [Termux packages](https://github.com/termux/termux-packages) repository, including the package name, version, short description, and homepage.

You can also search for any package and copy its installation command `pkg install <package> -y`.  

The package list is automatically updated every 2 to 3 hours.

## Download

[![Download apk](https://custom-icon-badges.demolab.com/badge/-Download-blue?style=for-the-badge&logo=download&logoColor=white "Download apk")](https://github.com/haithamaouati/Surfer/releases/download/1.0/Surfer_release.apk)

## Screenshot
![screenshot](screenshot.jpg)

### Surfer within Termux itself

 Using [fzf](https://github.com/junegunn/fzf) as a function that you can put in your `.bashrc`

Open `.bashrc` using `nano`:
```
nano ~/.bashrc`
```

###### fzf function

```
surfer () {
apt-cache search ".*" | fzf -e \
    --layout=reverse \
    --border-label="Ꞩurfer" \
    --border=rounded \
    --preview-label="Package details" \
    --preview-window='down,,,wrap,~1' \
    --prompt="Install package> " \
    --delimiter=' - ' \
    --with-nth=1,2 \
    --nth=1,2 \
    --preview 'apt-cache show --no-all-versions {1} | grep -Ev "^(SHA|MD5)" ' \
    --bind 'enter:become(pkg install {1})'
}
```
