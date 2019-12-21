import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:movie_app/app/modules/favorite/favorite_controller.dart';
import 'package:movie_app/app/modules/favorite/favorite_module.dart';

void main() {
  initModule(FavoriteModule());
  FavoriteController favorite;

  setUp(() {
    favorite = FavoriteModule.to.bloc<FavoriteController>();
  });

  group('FavoriteController Test', () {
    test("First Test", () {
      expect(favorite, isInstanceOf<FavoriteController>());
    });

    test("Set Value", () {
      expect(favorite.value, equals(0));
      favorite.increment();
      expect(favorite.value, equals(1));
    });
  });
}
