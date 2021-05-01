import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main_dialog_open_state_notifier_provider.dart';

class MainNavigatorObserver extends NavigatorObserver {
  BuildContext _context;

  MainNavigatorObserver(this._context);

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    final name = route.settings.name;
    if (name == 'dialog') {
      final mainDialogOpenStateNotifier =
          _context.read(mainDialogOpenStateNotifierProvider.notifier);
      mainDialogOpenStateNotifier.onOpen();
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    final name = route.settings.name;
    if (name == 'dialog') {
      final mainDialogOpenStateNotifier =
          _context.read(mainDialogOpenStateNotifierProvider.notifier);
      mainDialogOpenStateNotifier.onClose();
    }
  }
}
