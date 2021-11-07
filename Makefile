.PHONY: check
check:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
	. ${HOME}/.asdf/asdf.sh
	asdf plugin add flutter
	asdf install
	asdf reshim
	flutter format -n --set-exit-if-changed .
	flutter pub get
	flutter build web
