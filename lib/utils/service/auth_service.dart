
import 'package:abgtools/model/envrinementModel.dart';
import 'package:abgtools/setting/storage_cache.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final RxBool isLogin = true.obs;
  final RxInt isProfail = 4.obs;
  EnvrinementModel? env;
  Future<AuthService> init() async {
    env = await getEnvirenment();
    if (env != null) {
      isLogin.value = true;
      return this;
    }
    isLogin.value = false;
    return this;
  }

  
  Future<void> setLogin(bool login) async {
    isLogin.value = login;

    // env = env = (await getEnvirenment())?? EnvrinementModel(access_token: '', lisenceType: 0, permissions: [], token_type: '', user: User(city: 0, email: '', id: 0, name: '', organization: '', role: 0));
    env = await getEnvirenment();
  }
}
