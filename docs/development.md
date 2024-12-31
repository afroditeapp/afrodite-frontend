
# Translations

The translations are in the `translations` Android Studio project to make
editing translations easier.

# Native code

If Rust dependencies are changed, update
LICENSE file of native_utils_ffi Dart package with

```
make update-licenses-for-native-utils
```

# Firebase

If you modify the Firebase projects from Firebase web UI, you
can update Firebase related config using command
```
flutterfire configure
```

Install instructions for that tool is at
<https://firebase.google.com/docs/flutter/setup?platform=android>


## Local web build development

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
