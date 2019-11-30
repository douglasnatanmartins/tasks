import 'package:tasks/src/core/contracts/usecase.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';
import '../repositories/category_repository_contract.dart';

class GetCategoryRepository implements UseCase {
  CategoryRepositoryContract getRepository() {
    return CategoryRepository();
  }
}
