import 'package:hooks_riverpod/hooks_riverpod.dart';

/// StateNotifier with dialog open/close state
class MainDialogOpenStateNotifier extends StateNotifier<bool> {
  MainDialogOpenStateNotifier() : super(false);

  /// Called when dialog open
  void onOpen() {
    state = true;
  }

  /// Called when dialog close
  void onClose() {
    state = false;
  }
}

// ignore: top_level_function_literal_block
final mainDialogOpenStateNotifierProvider =
    StateNotifierProvider<MainDialogOpenStateNotifier, bool>((_) {
  return MainDialogOpenStateNotifier();
});
