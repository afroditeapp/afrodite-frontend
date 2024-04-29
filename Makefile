
# Default rule
default:
	exit 0

update-api-bindings:
	openapi-generator-cli generate \
	-i http://localhost:3000/api-doc/pihka_api.json \
	-g dart \
	-o packages/api_client

update-freezed-code:
	icegen --code-dir lib/model/freezed

update-drift-code:
	cd packages/database && dart run build_runner build

update-translations:
	xml2arb --input-dir translations/app/src/main/res --output-dir lib/l10n --arb-file-name-template app_en.arb
	flutter gen-l10n

update-app-icon:
	dart run flutter_launcher_icons

update-native-utils-ffi-code:
	cd packages/native_utils && dart run ffigen --config ffigen.yaml

update-licenses-for-native-utils:
	cd packages/native_utils/rust_utils && cargo about generate --threshold 1.0 --fail -o ../LICENSE about.hbs

watch-translations:
	fswatch -o -e Updated translations/app/src/main/res | xargs -n1 -I{} make update-translations

watch-translations-linux:
	fswatch -m poll_monitor -o -e Updated translations/app/src/main/res/values/strings.xml | xargs -n1 -I{} make update-translations

watch-freezed-code:
	fswatch -o -e Updated lib/model/freezed | xargs -n1 -I{} make update-freezed-code

clean:
	flutter clean
	cd packages/database && flutter clean
	cd packages/api_client && flutter clean
	cd packages/native_utils && flutter clean
	cd packages/native_utils/rust_utils && cargo clean

code-stats:
	@/bin/echo -n "Lines:"
	@find \
	lib \
	-name '*.dart' | xargs wc -l | tail -n 1
	@echo "\nCommits:   `git rev-list --count HEAD` total"
