App's strings are stored in translations/app/src/main/res/values/strings.xml.
If that file is edited, command "make update-translations" needs to be
executed.

After editing data classes in lib/model/freezed, command
"make update-freezed-code" needs to be executed.

After editing Drift related code found from
packages/database_account, command
"make update-drift-code-account"
needs to be executed.

After editing Drift related code found from
packages/database_common, command
"make update-drift-code-common"
needs to be executed.

When editing database code, don't create database migrations as
app is not in production.
