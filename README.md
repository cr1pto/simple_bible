# simple_bible

<a href="https://github.com/cr1pto/simple_bible/actions"><img src="https://github.com/cr1pto/simple_bible/workflows/Flutter_Tests/badge.svg" alt="Build Status"></a>

This project represents a very simple mobile app for the Bible.

![Simple Bible](/screen_samples/simple_bible.jpeg?raw=true "Simple Bible")

## Building the project

### Prerequisites

- You need flutter to build this app.  Download it here: https://docs.flutter.dev/get-started/install?gclid=Cj0KCQjwj7CZBhDHARIsAPPWv3e9dUqtof6PAihBeTejkeBN8VtmisQom4m0FzsSjP2Hxznl0fWmH9QaAo0YEALw_wcB&gclsrc=aw.ds

Below is what I have on my machine for what is currently used to build the application.  
- Flutter: 3.0.2
- Java Zulu JDK (open java jdk): 17.0.1
- Python: 3.9.7
- Dart: 2.17.3
- Ruby: 2.6.8p205

I use Android Studio to run my builds. I have been using a couple of Android Pixel emulators as well as an iPhone 

If you have some trouble getting this to run, drop an issue on the repo.

```zsh
cr1pto simple_bible % flutter --version
Flutter 3.0.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision cd41fdd495 (4 months ago) • 2022-06-08 09:52:13 -0700
Engine • revision f15f824b57
Tools • Dart 2.17.3 • DevTools 2.12.2
cr1pto simple_bible % java --version
openjdk 17.0.1 2021-10-19 LTS
OpenJDK Runtime Environment Zulu17.30+15-CA (build 17.0.1+12-LTS)
OpenJDK 64-Bit Server VM Zulu17.30+15-CA (build 17.0.1+12-LTS, mixed mode, sharing)
cr1pto simple_bible % python --version
Python 3.9.7
cr1pto simple_bible % ruby --version
ruby 2.6.8p205 (2021-07-07 revision 67951) [universal.arm64e-darwin21]
```

- Run `flutter doctor` to ensure that everything works as expected from the command line.
### Running the app


### Running the app wireless

Step 1:
Connect the device to the host computer with a USB cable.

Step 2:
Set the target device to listen for a TCP/IP connection on port 5555
    `adb tcpip 5555`

Step 3:
Disconnect the USB cable from the target device.

Step 4:
Connect to the device by its IP address
    `adb connect <device_ip_address>`

Optional:
Confirm that your host computer is connected to the target device:
    `adb devices`
