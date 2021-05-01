
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ダイアログ開閉状態を持つStateNotifier
class MainDialogOpenStateNotifier extends StateNotifier<bool> {
  MainDialogOpenStateNotifier() : super(false);

  /// ダイアログが開かれたときに呼ばれる
  void onOpen() {
    state = true;
  }

  /// ダイアログが閉じられたときに呼ばれる
  void onClose() {
    state = false;
  }
}

// ignore: top_level_function_literal_block
final mainDialogOpenStateNotifierProvider = StateNotifierProvider<MainDialogOpenStateNotifier, bool>((_) {
  return MainDialogOpenStateNotifier();
});
