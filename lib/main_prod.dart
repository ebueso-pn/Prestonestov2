import 'package:prestonesto/main_common.dart';
import 'package:prestonesto/utils/enviroment.dart';

Future<void> main() async {
  await mainCommon(Environment.prod);
}
