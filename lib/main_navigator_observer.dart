import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'main_dialog_open_state_notifier_provider.dart';

class MainNavigatorObserver extends NavigatorObserver {
  WidgetRef _ref;

  MainNavigatorObserver(this._ref);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final name = route.settings.name;
    if (name == 'dialog') {
      final mainDialogOpenStateNotifier =
          _ref.read(mainDialogOpenStateNotifierProvider.notifier);
      mainDialogOpenStateNotifier.onOpen();
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final name = route.settings.name;
    if (name == 'dialog') {
      final mainDialogOpenStateNotifier =
          _ref.read(mainDialogOpenStateNotifierProvider.notifier);
      mainDialogOpenStateNotifier.onClose();
    }
  }
}
