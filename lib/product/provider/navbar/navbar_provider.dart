import 'package:riverpod/riverpod.dart';

final navbarSelectedProvider = StateNotifierProvider(
  (ref) {
    return NavbarSelectedStateNotifier();
  },
);

class NavbarSelectedStateNotifier extends StateNotifier<int> {
  NavbarSelectedStateNotifier() : super(0);

  void notify(int index) async {
    state = index;
  }
}
