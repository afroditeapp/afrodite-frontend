
# Default rule
default:
	exit 0

update-api-bindings:
	openapi-generator-cli generate \
	-i http://localhost:3000/api-doc/pihka_api.json \
	-g dart \
	-o api_client

update-generated-code:
	dart run build_runner build

update-localizations:
	flutter gen-l10n

code-stats:
	@/bin/echo -n "Lines:"
	@find \
	lib \
	-name '*.dart' | xargs wc -l | tail -n 1
	@echo "\nCommits:   `git rev-list --count HEAD` total"
