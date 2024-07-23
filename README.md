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
Check which shell starts when you open a new console window. This is your default shell.
```
echo $SHELL
```

Based on your default shell, choose one of the commands below.
- `bash`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.bash_profile
```

- `zsh`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.zshenv
```

- `fish`
```
fish_add_path -g -p /usr/bin/flutter/bin
```

- `csh`
```
echo 'setenv PATH "/usr/bin/flutter/bin:$PATH"' >> ~/.cshrc
```

- `tcsh`
```
echo 'setenv PATH "/usr/bin/flutter/bin:$PATH"' >> ~/.tcshrc
```

- `ksh`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.profile
```

- `sh`
```
echo 'export PATH="/usr/bin/flutter/bin:$PATH"' >> ~/.profile
```

To apply this change, restart all open terminal sessions.

### Check your development setup
Open a shell and run the following command:
```
flutter doctor
```

You do not need ALL components. It should resemble something like this:
```
Running flutter doctor...
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.16.7, on macOS 14.5 23F79 darwin-arm64, locale en-US)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.4)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.1)
[✓] VS Code (version 1.91.0)
[✓] Connected device (3 available)
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

## Cloning
To clone this repository, run this command:
```
git clone git@github.com:DIPrLab/bluetooth_detector.git
```

## Getting packages and setting up your code editor
To get all the Flutter plugins, run the following to get the most updated dependencies available:
```
flutter pub get
flutter pub upgrade
flutter pub upgrade --major-versions
```

Now run this command:
```
flutter pub outdated
```
If there's a package in the generated "table", this is perfectly fine as long as something similar to what is below is generated after this "table".
```
You are already using the newest resolvable versions listed in the 'Resolvable' column.
Newer versions, listed in 'Latest', may not be mutually compatible.
```

After run all of these commands, you're set to start coding! All files to edit will be in the folder `lib` in files ending in `.dart`.
