
# Default rule
default:
	exit 0

fmt:
	find . \
	-type f \
	-name "*.dart" \
	! -name "*.g.dart" \
	! -name "*.freezed.dart" \
	! -path "./packages/api_client/*" \
	! -path "./lib/l10n/*" \
	! -path "*/.dart_tool/*" \
	| \
	xargs dart format \
	--show none \
	--page-width 100

check-fmt:
	find . \
	-type f \
	-name "*.dart" \
	! -name "*.g.dart" \
	! -name "*.freezed.dart" \
	! -path "./packages/api_client/*" \
	! -path "./lib/l10n/*" \
	! -path "*/.dart_tool/*" \
	| \
	xargs dart format \
	--show none \
	--page-width 100 \
	--summary none \
	--output none \
	--set-exit-if-changed

update-api-bindings:
	openapi-generator-cli generate \
	-i http://localhost:3002/api-doc/app_api.json \
	-g dart \
	-o packages/api_client \
	--global-property apiTests=false,modelTests=false,apiDocs=false,modelDocs=false

update-freezed-code:
	icegen --code-dir lib/model/freezed

update-drift-code-account-background:
	cd packages/database_account_background && dart run build_runner build
update-drift-code-account-foreground:
	cd packages/database_account_foreground && dart run build_runner build
update-drift-code-common-background:
	cd packages/database_common_background && dart run build_runner build
update-drift-code-common-foreground:
	cd packages/database_common_foreground && dart run build_runner build

update-translations:
	xml2arb --input-dir translations/app/src/main/res --output-dir lib/l10n --arb-file-name-template app_en.arb
	flutter gen-l10n

update-app-icon:
	dart run flutter_launcher_icons

update-native-utils-ffi-code:
	cd packages/native_utils_ffi && dart run ffigen --config ffigen.yaml

update-licenses-for-native-utils:
	cd packages/native_utils_ffi/rust_utils && cargo about generate --threshold 1.0 --fail -o ../LICENSE about.hbs

watch-translations:
	fswatch -o -e Updated translations/app/src/main/res | xargs -n1 -I{} make update-translations

watch-translations-linux:
	fswatch -m poll_monitor -o -e Updated translations/app/src/main/res/values/strings.xml | xargs -n1 -I{} make update-translations

watch-freezed-code:
	fswatch -o -e Updated lib/model/freezed | xargs -n1 -I{} make update-freezed-code

remove-and-download-drift-web-dependencies:
	rm -f web/drift_worker.js
	rm -f web/sqlite3.wasm
	cd web && curl "https://github.com/simolus3/drift/releases/download/drift-2.26.0/drift_worker.js" -L -o drift_worker.js
	# Download for sqlite3-2.7.5 does not exist so download older version
	cd web && curl "https://github.com/simolus3/sqlite3.dart/releases/download/sqlite3-2.7.4/sqlite3.wasm" -L -o sqlite3.wasm

build-android-release:
	flutter build apk --release --dart-define=GIT_COMMIT_ID=`git rev-parse --short HEAD`

build-ios-release:
	flutter build ios --release --dart-define=GIT_COMMIT_ID=`git rev-parse --short HEAD`

build-web-release-tar-linux:
	flutter build web --release --wasm
	cd build && tar --owner=0 --group=0 -czf web-release.tar.gz web
	@echo "Packaged build/web-release.tar.gz"

build-web-release-tar-macos:
	flutter build web --release --wasm
	cd build && tar --uid=0 --gid=0 -czf web-release.tar.gz web
	@echo "Packaged build/web-release.tar.gz"

build-web-profile-tar-linux:
	flutter build web --profile --wasm
	cd build && tar --owner=0 --group=0 -czf web-profile.tar.gz web
	@echo "Packaged build/web-profile.tar.gz"

build-web-profile-tar-macos:
	flutter build web --profile --wasm
	cd build && tar --uid=0 --gid=0 -czf web-profile.tar.gz web
	@echo "Packaged build/web-profile.tar.gz"

clean:
	flutter clean
	cd packages/database && flutter clean
	cd packages/database_account_background && flutter clean
	cd packages/database_account_foreground && flutter clean
	cd packages/database_common_background && flutter clean
	cd packages/database_common_foreground && flutter clean
	cd packages/database_converter && flutter clean
	cd packages/database_model && flutter clean
	cd packages/database_provider && flutter clean
	cd packages/database_provider_native && flutter clean
	cd packages/database_provider_web && flutter clean
	cd packages/database_utils && flutter clean
	cd packages/api_client && flutter clean
	cd packages/encryption && flutter clean
	cd packages/encryption_common && flutter clean
	cd packages/encryption_native && flutter clean
	cd packages/encryption_web && flutter clean
	cd packages/utils && flutter clean
	cd packages/native_utils && flutter clean
	cd packages/native_utils_common && flutter clean
	cd packages/native_utils_ffi && flutter clean
	rm -rf packages/native_utils_ffi/android/.cxx
	cd packages/native_utils_ffi/rust_utils && cargo clean
	rm -rf android/app/.cxx

code-stats:
	@/bin/echo -n "Lines:"
	@find \
	lib \
	packages/database \
	packages/database_account_background \
	packages/database_account_foreground \
	packages/database_common_background \
	packages/database_common_foreground \
	packages/database_converter \
	packages/database_model \
	packages/database_provider \
	packages/database_provider_native \
	packages/database_provider_web \
	packages/database_utils \
	packages/encryption \
	packages/encryption_common \
	packages/encryption_native \
	packages/encryption_web \
	packages/utils \
	packages/native_utils \
	packages/native_utils_common \
	packages/native_utils_ffi/rust_utils/src \
	packages/native_utils_ffi/lib \
	'(' \
	-name '*.dart' \
	-or \
	-name '*.rs' \
	')' \
	-and \
	! -name '*.g.dart' \
	-and \
	! -name 'native_utils_ffi_generated.dart' \
	-and \
	! -name '*.freezed.dart' | xargs wc -l | tail -n 1
	@echo "\nCommits:   `git rev-list --count HEAD` total"
