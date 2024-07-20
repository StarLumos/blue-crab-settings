# Blue Crab

Blue Crab is an app that scans for and identifies Bluetooth tracking devices. The goal of this project is to prevent stalking and to provide wider services for more platforms than what is currently offered (i.e. Apple and Google/Android).

## Getting Started
### Downloading Flutter on Linux desktop
- Verify that you have `bash`, `file`, `mkdir`, `rm`, and `which` installed on your device
```
which bash file mkdir rm which
/bin/bash
/usr/bin/file
/bin/mkdir
/bin/rm
which: shell built-in command
```
- If these packages aren't installed, make sure you install them.

- Install `curl`, `git`, `unzip`, `xz-utils`, `zip`, and `libglu1-mesa`
```
sudo apt-get update -y && sudo apt-get upgrade -y;
```
```
sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
```

- Install `clang`, `cmake`, `ninja-build`, `pkg-config`, `libgtk-3-dev`, and `libstdc++-12-dev`
```
sudo apt-get install \
    clang cmake git \
    ninja-build pkg-config \
    libgtk-3-dev liblzma-dev \
    libstdc++-12-dev
```

- Navigate to [the 'Install Flutter' section in the official Flutter website](https://docs.flutter.dev/get-started/install).
- Scroll down to the "Download and install" tab and click on it if it's not already showing.
- Download `flutter_linux_3.22.3-stable.tar.xz`
- Create a folder where you can install Flutter. It does NOT have to be in `/usr/bin/` like the site suggests, although, of course, it can.
- Extract the file into the directory you want to store the Flutter SDK.
```
tar -xf ~/Downloads/flutter_linux_3.22.3-stable.tar.xz -C <your directory location>
```
- When finished, the Flutter SDK should be in `/<your directory location>/flutter`

### Add Flutter to your PATH
- Check which shell starts when you open a new console window. This is your default shell.
```
echo $SHELL
```
- Based on your default shell, choose one of the commands below.
- - `bash`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.bash_profile
```
- - `zsh`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.zshenv
```
- - `fish`
```
fish_add_path -g -p /usr/bin/flutter/bin
```
- - `csh`
```
echo 'setenv PATH "/usr/bin/flutter/bin:$PATH"' >> ~/.cshrc
```
- - `tcsh`
```
echo 'setenv PATH "/usr/bin/flutter/bin:$PATH"' >> ~/.tcshrc
```
- - `ksh`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.profile
```
- - `sh`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.profile
```
- To apply this change, restart all open terminal sessions.

### Check your development setup
- Open a shell.
- Run the following command:
```
flutter doctor
```
- You do not need ALL components. It should resemble something like this:
```
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):

[✓] Flutter (Channel stable, 3.22.1, on Ubuntu 20.04 (LTS), locale en)
[!] Android toolchain - develop for Android devices
[!] Chrome - develop for the web
[!] Android Studio (not installed)
[✓] Linux toolchain - develop for Linux desktop
[✓] VS Code (version 1.89)
[✓] Connected device (1 available)
[✓] Network resources

! Doctor found issues in 3 categories.
```

### Troubleshoot Flutter doctor issues
- Run the following command:
```
flutter doctor -v
```

Note: Installing the Flutter SDK means that all the packages (including the Dart SDK) are already installed, so nothing else has to be installed separately.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
