command -v gnome-pomodoro > /dev/null && 
(
    cd $(mktemp -d) &&
    $(which git) clone https://github.com/kantord/i3-gnome-pomodoro &&
    cd i3-gnome-pomodoro &&
    sudo $(which pip3) install -r requirements.txt --ignore-installed &&
    sudo rm /usr/bin/i3-gnome-pomodoro >& /dev/null;
    sudo cp pomodoro-client.py /usr/bin/i3-gnome-pomodoro &&
    /usr/bin/i3-gnome-pomodoro status
) || echo "Installation failed. Please make sure you have gnome-pomodoro installed."