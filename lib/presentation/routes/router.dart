import 'package:auto_route/auto_route_annotations.dart';

import '../currency_info.dart';
import '../home_widget.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomeWidget, initial: true),
    MaterialRoute(
      fullscreenDialog: true,
      page: CurrencyInfoModal,
    ),
  ],
  generateNavigationHelperExtension: true,
)
class $Router {}
