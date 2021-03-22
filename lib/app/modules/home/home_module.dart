import 'conta/conta_controller.dart';
import 'card/card_controller.dart';
import 'card/card_page.dart';
import 'conta/conta_page.dart';
import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => CardController()),
        Bind((i) => ContaController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/card',
            child: (_, args) =>
                CardPage(neww: args.data[0], card: args.data[1]),
            transition: TransitionType.rightToLeft),
        ModularRouter('/conta',
            child: (_, args) =>
                ContaPage(neww: args.data[0], conta: args.data[1]),
            transition: TransitionType.rightToLeft),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
