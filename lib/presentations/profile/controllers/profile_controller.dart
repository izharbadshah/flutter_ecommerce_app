import 'package:get/get.dart';
import '../../../core/local_storage/storage_service.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/models/user.dart';
import '../../../services/user_service.dart';
import '/core/errors/app_exception.dart';


class ProfileController extends GetxController {
  final UserService _userService;

  ProfileController(this._userService);

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }


  Future<void> fetchProfile() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final storageService = Get.find<StorageService>();
      final userId = storageService.userId ?? 1;
      user.value = await _userService.fetchUser(userId);
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    final storageService = Get.find<StorageService>();
    await storageService.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
