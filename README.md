# Afrodite
Dating app frontend


## Update server API bindings

1. Install node version manager (nvm) <https://github.com/nvm-sh/nvm>
2. Install latest node LTS with nvm. For example `nvm install 18`
3. Install openapi-generator from npm. `npm install @openapitools/openapi-generator-cli -g`
4. Start Afrodite backend in debug mode.
5. Generate bindings
```
openapi-generator-cli generate -i http://localhost:3000/api-doc/dating-app-backend.json -g dart -o api_client
```

## Update generated code (freezed library)

```
dart run build_runner build
```


## Android MacOS local DNS server for correct certificate handling

### DNS server
```
brew install dnsmasq
```

/opt/homebrew/etc/dnsmasq.conf
```
listen-address=::1,127.0.0.1
address=/DOMAIN/10.0.2.2
port=5353
```

And start DNS

```
/opt/homebrew/opt/dnsmasq/sbin/dnsmasq -d -q --keep-in-foreground -C /opt/homebrew/etc/dnsmasq.conf
```

### Redirect

./Library/Android/sdk/platform-tools/adb devices

telnet 127.0.0.1 5554


# Update localizations

Run `make update-localizations`

The localizations are in the `translations` Android Studio project to make
editing translations easier.

### After git clone

1. Install native code building dependencies. Instructions for that are in
this file.

2. Start Android emulator and run `flutter run`.

# About Assets

Google Sign In with buttons are from
<https://developers.google.com/static/identity/images/signin-assets.zip>
zip file found from <https://developers.google.com/identity/branding-guidelines>

# Building native code

1. Install Rust

2. Instal targets

```
rustup target add aarch64-linux-android
rustup target add armv7-linux-androideabi
rustup target add i686-linux-android
rustup target add x86_64-linux-android
```

3. Build app normally

4. If Rust dependencies are changed download cargo about and update
LICENSE file of native_utils_ffi Dart package:

```
cargo install cargo-about --locked
make update-licenses-for-native-utils
```

# Building for iOS and iOS simulator

1. Install cocoapods

<https://guides.cocoapods.org/using/getting-started.html#sudo-less-installation>

2. Xcode and related tools are also needed

3. Install Rust targets

```
rustup target add aarch64-apple-ios
rustup target add aarch64-apple-ios-sim
rustup target add x86_64-apple-ios
```

# Firebase

If you modify the Firebase projects from Firebase web UI, you
can update Firebase related config using command
```
flutterfire configure
```

Install instructions for that tool is at
<https://firebase.google.com/docs/flutter/setup?platform=android>

# Local web build development

Create Visual Studio Code launch configuration like this:

```
 {
    "name": "app (Flutter Chrome)",
    "program": "lib/main.dart",
    "deviceId": "chrome",
    "request": "launch",
    "type": "dart",
    "args": [
        "--wasm",
        "--web-hostname",
        "localhost",
        "--web-port",
        "51758",
        "--web-browser-flag",
        "--disable-web-security",
    ]
}
```

The port must be 51758 as Sign in with Google
authorized JavaScript origins config currently includes URL
http://localhost:51758

The backend runs on port 3000 so web security needs to be
disabled.

## Adding push notification and Sign in with Google support

Add web client ID by modifying web/index.html line

```html
<meta name="google-signin-client_id" content="TODO">
```

Add iOS client ID by modifying ios/Runner/Info.plist location

```xml
<!-- Copied from downloaded OAuth 2 client info. Value for key REVERSED_CLIENT_ID. -->
<string>TODO</string>
```

Also add files

```
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
lib/firebase_options.dart
lib/sign_in_with_google_ids.dart
firebase.json
```

## Add iOS support

The file ios/Runner.xcodeproj is removed to hide development team ID, so it
should be added back somehow.
