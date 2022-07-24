import 'package:hooks_riverpod/hooks_riverpod.dart';

// we need this provider in both the clock widget
// and in the session screen
final sessionTimeProvider = StateProvider<int>((ref) {
  return 25;
});
