
# Default rule
default:
	exit 0

update-api-bindings:
	openapi-generator-cli generate \
	-i http://localhost:3000/api-doc/pihka_api.json \
	-g dart \
	-o packages/api_client

update-generated-code:
	dart run build_runner build

update-translations:
	xml2arb --input-dir translations/app/src/main/res --output-dir lib/l10n --arb-file-name-template app_en.arb
	flutter gen-l10n

update-app-icon:
	dart run flutter_launcher_icons

watch-translations:
	fswatch -o -e Updated translations/app/src/main/res | xargs -n1 -I{} make update-translations

watch-translations-linux:
	fswatch -m poll_monitor -o -e Updated translations/app/src/main/res/values/strings.xml | xargs -n1 -I{} make update-translations

code-stats:
	@/bin/echo -n "Lines:"
	@find \
	lib \
	-name '*.dart' | xargs wc -l | tail -n 1
	@echo "\nCommits:   `git rev-list --count HEAD` total"
