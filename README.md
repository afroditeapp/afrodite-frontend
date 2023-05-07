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
