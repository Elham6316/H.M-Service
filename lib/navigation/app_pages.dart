import 'package:get/get.dart';
import 'package:hm_service/screens/admin/clients/clients_bindings.dart';
import 'package:hm_service/screens/admin/clients/clients_screen.dart';
import 'package:hm_service/screens/admin/home/home_admin_bindings.dart';
import 'package:hm_service/screens/admin/home/home_admin_screen.dart';
import 'package:hm_service/screens/admin/requests/requests_bindings.dart';
import 'package:hm_service/screens/admin/requests/requests_screen.dart';
import 'package:hm_service/screens/admin/technician/technician_binding.dart';
import 'package:hm_service/screens/admin/technician/technician_screen.dart';
import 'package:hm_service/screens/chat/chat_binding.dart';
import 'package:hm_service/screens/chat/chat_screen.dart';
import 'package:hm_service/screens/signin/signin_bindings.dart';
import 'package:hm_service/screens/signin/signin_screen.dart';
import 'package:hm_service/screens/signup/signup_bindings.dart';
import 'package:hm_service/screens/signup/signup_screen.dart';
import 'package:hm_service/screens/splash/splash_%20bindings.dart';
import 'package:hm_service/screens/splash/splash_screen.dart';
import 'package:hm_service/screens/technician/comment/comment_binding.dart';
import 'package:hm_service/screens/technician/comment/comment_screen.dart';
import 'package:hm_service/screens/technician/home/technician_home_binding.dart';
import 'package:hm_service/screens/technician/home/technician_home_screen.dart';
import 'package:hm_service/screens/user/home/user_home_bindings.dart';
import 'package:hm_service/screens/user/home/user_home_screen.dart';
import 'package:hm_service/screens/user/my_request/my_request_binding.dart';
import 'package:hm_service/screens/user/my_request/my_request_screen.dart';
import 'package:hm_service/screens/user/request/request_binding.dart';
import 'package:hm_service/screens/user/request/request_screen.dart';
import 'package:hm_service/screens/welcome/welcome_bindings.dart';
import 'package:hm_service/screens/welcome/welcome_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = <GetPage>[
    GetPage(
        name: Routes.splash,
        page: () => const SplashScreen(),
        binding: SplashBindings()),
    GetPage(
        name: Routes.welcome,
        page: () => const WelcomeScreen(),
        binding: WelcomeBindings()),
    GetPage(
        name: Routes.signin,
        page: () => const SignInScreen(),
        binding: SignInBinding()),
    GetPage(
        name: Routes.signup,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
        name: Routes.homeAdmin,
        page: () => const HomeAdminScreen(),
        binding: HomeAdminBindings()),

    GetPage(
        name: Routes.userHome,
        page: () => const UserHomeScreen(),
        binding: UserHomeBinding()),

    GetPage(
        name: Routes.userRequest,
        page: () => const RequestScreen(),
        binding: RequestBinding()),

    GetPage(
        name: Routes.myRequest,
        page: () => const MyRequestScreen(),
        binding: MyRequestBinding()),

    GetPage(
        name: Routes.chat,
        page: () => const ChatScreen(),
        binding: ChatBinding()),

    GetPage(
        name: Routes.technicianHome,
        page: () => const TechnicianHomeScreen(),
        binding: TechnicianHomeBinding()),

    GetPage(
        name: Routes.comments,
        page: () => const CommentsScreen(),
        binding: CommentBinding()),

    GetPage(
        name: Routes.clientsList,
        page: () => const ClientsScreenList(),
        binding: ClientsBindingList()),

    GetPage(
        name: Routes.technicianList,
        page: () => const TechnicianScreenList(),
        binding: TechnicianBindingList()),

    GetPage(
        name: Routes.requestsList,
        page: () => const RequestsScreenList(),
        binding: RequestsBindingList()),
  ];
}
