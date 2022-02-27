import 'package:bloc/bloc.dart';
import 'package:cantio/data/providers/account_provider.dart';
import 'package:cantio/data/repositories/account_repository.dart';
import 'package:cantio/logic/account/account_event.dart';
import 'package:cantio/logic/account/account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc(AccountRepository accountRepository)
      : _accountRepository = accountRepository,
        super(InitalAccountState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is GetUser) {
      yield Loading();
      final user = await _accountRepository.getProfile();
      print(user);
      yield UserRetrieved(cantioUser: user);
    }
  }

  // Stream<AccountState> _mapGetUserToState(GetUser event) async* {
    
  // }
}
