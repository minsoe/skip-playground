# SkipPlayground

This is a free [Skip](https://skip.tools) dual-platform app project.
It builds a native app for both iOS and Android.

## Building

This project is both a stand-alone Swift Package Manager module,
as well as an Xcode project that builds and transpiles the project
into a Kotlin Gradle project for Android using the Skip plugin.

Building the module requires that Skip be installed using
[Homebrew](https://brew.sh) with `brew install skiptools/skip/skip`.

This will also install the necessary transpiler prerequisites:
Kotlin, Gradle, and the Android build tools.

Installation prerequisites can be confirmed by running `skip checkup`.

## Testing

The module can be tested using the standard `swift test` command
or by running the test target for the macOS destination in Xcode,
which will run the Swift tests as well as the transpiled
Kotlin JUnit tests in the Robolectric Android simulation environment.

Parity testing can be performed with `skip test`,
which will output a table of the test results for both platforms.

## Before Running
Create an account in [TMDB](https://www.themoviedb.org) and get `API Read Access Token` from Settings - [API](https://www.themoviedb.org/settings/api)

###Android
In `local.properties` file, add tmdb token as following
`TMDB_TOKEN=... your token`

###iOS

Copy `SkipPlaygroud.xcconfig` and name it as something like `SkipPlaygroud_DEGUG.xcconfig` and add tmdb token as following

`TMDB_TOKEN=... your token`   

And, update the configuration in Xcode by following these steps

1. Go to your project settings by clicking on the project file in the Project Navigator.
2. Select the project's `info` tab.
3. Open `Debug` and update the configuration file as the following. 
<img alt="Project Configuration" src="../image/xconfig-location.png" style="width: 100%;" />


## Running

Xcode and Android Studio must be downloaded and installed in order to
run the app in the iOS simulator / Android emulator.
An Android emulator must already be running, which can be launched from 
Android Studio's Device Manager.

To run both the Swift and Kotlin apps simultaneously, 
launch the SkipPlaygroundApp target from Xcode.
A build phases runs the "Launch Android APK" script that
will deploy the transpiled app a running Android emulator or connected device.
Logging output for the iOS app can be viewed in the Xcode console, and in
Android Studio's logcat tab for the transpiled Kotlin app.
