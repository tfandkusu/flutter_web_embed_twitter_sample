.PHONY: check
check:
	flutter format -n --set-exit-if-changed .
	flutter pub get
	flutter build web
