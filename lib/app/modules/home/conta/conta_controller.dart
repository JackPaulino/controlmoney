import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'conta_controller.g.dart';


@Injectable()
class ContaController = _ContaControllerBase with _$ContaController;

abstract class _ContaControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
  