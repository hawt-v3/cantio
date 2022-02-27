import 'package:bloc/bloc.dart';
import 'package:cantio/data/providers/auth_provider.dart';
import 'package:cantio/logic/auth/auth_event.dart';
import 'package:cantio/logic/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthProvider _authProvider;

  AuthBloc(AuthProvider authProvider)
      : _authProvider = authProvider,
        super(InitialAuthenticationState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final User? user = await _authProvider.getCurrentUser();
      if (user != null) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedOut) {
      _authProvider.logout();
    }
  }
}
