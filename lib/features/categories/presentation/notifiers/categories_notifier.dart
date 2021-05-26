import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/usecases/get_categories.dart';

import 'categories_state.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final GetAllCategories allCategories;

  CategoriesNotifier(this.allCategories) : super(CategoriesInitial());
  void fetchCategory() async {
    state = CategoriesLoading();
    final result = await allCategories(NoParams());
    result.fold(
      (failure) => state = CategoriesError(mapFailureToMessage(failure)),
      (trivia) => state = CategoriesLoaded(trivia),
    );
  }
}
