import 'package:bloc/bloc.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugLog(transition);
    super.onTransition(bloc, transition);
  }
}