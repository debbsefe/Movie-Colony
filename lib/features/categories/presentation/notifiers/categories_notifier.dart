import 'package:injectable/injectable.dart';

import '../../../../core/notifiers/generic_state_notifier.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/categories.dart';
import '../../domain/usecases/get_categories.dart';

@LazySingleton()
class CategoriesNotifier extends GenericStateNotifier<List<Categories>> {
  CategoriesNotifier(this.allCategories);

  final GetAllCategories allCategories;

  void fetchCategory() {
    sendRequest(() async {
      return await allCategories(NoParams());
    });
  }
}
