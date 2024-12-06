import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SearchControllerM extends GetxController {
  RxBool isSearching = false.obs;
  RxList<UserModel> searchList = <UserModel>[].obs;

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchList.clear();
    }
  }

  void filterList(String query, List<UserModel> fullList) {
    searchList.value = fullList
        .where((user) =>
            user.name!.toLowerCase().contains(query.toLowerCase()) ||
            user.email!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
