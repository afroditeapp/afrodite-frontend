# pihka-frontend
Dating app frontend


## Update server API bindings

1. Install node version manager (nvm) <https://github.com/nvm-sh/nvm>
2. Install latest node LTS with nvm. For example `nvm install 18`
3. Install openapi-generator from npm. `npm install @openapitools/openapi-generator-cli -g`
4. Start pihka backend in debug mode.
5. Generate bindings `openapi-generator-cli generate -i
   http://localhost:3000/api-doc/pihka_api.json -g dart -o api_client`

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
