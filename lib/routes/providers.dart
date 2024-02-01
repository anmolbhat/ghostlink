import 'package:ciphat/pages/viewModels.dart';
import 'package:provider/provider.dart';

// Import your view models
// import 'pages/pages.dart';

class Providers {
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
    ),
    ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(),
    ),
    ChangeNotifierProvider<ChatViewModel>(
      create: (_) => ChatViewModel(),
    ),
    // ChangeNotifierProvider<UserViewModel>(
    //   create: (_) => UserViewModel(),
    // ),
  ];
}
