//import 'dart:async';
//import 'package:meta/meta.dart';
//import 'package:bloc/bloc.dart';
//import 'authentication_event.dart';
//import 'authentication_state.dart';
//import 'package:greenwaydispatch/userRepository.dart';
//
//class AuthenticationBloc
//    extends Bloc<AuthenticationEvent, AuthenticationState> {
//  final UserRepository userRepository;
//
//  const AuthenticationBloc({@required this.userRepository})
//      : assert(userRepository != null);
//
//  @override
//  Future<void> close() async {
//    // dispose objects
//    await super.close();
//  }
//
//  @override
//  AuthenticationState get initialState => AuthenticationUninitialized();
//
//  @override
//  Stream<AuthenticationState> mapEventToState(
//      AuthenticationEvent event) async* {
//    if (event is AppStarted) {
//      final bool hasToken = await userRepository.hasToken();
//      if (hasToken) {
//        final phoneNumber = await userRepository.getUsername();
//        yield AuthenticationAuthenticated(phoneNumber: phoneNumber);
//      } else {
//        yield AuthenticationUnauthenticated();
//      }
//    }
//    if (event is LoggedIn) {
//      yield AuthenticationLoading();
//      await userRepository.persistToken(event.token);
//      final phoneNumber = await userRepository.getUsername();
//      yield AuthenticationAuthenticated(phoneNumber: phoneNumber);
//    }
//    if (event is LoggedOut) {
//      yield AuthenticationLoading();
//      await userRepository.deleteToken();
//      yield AuthenticationUnauthenticated();
//    }
//    // if (event is CheckSync) {
//    //   final username = await userRepository.getUsername();
//    //   event.ordersBloc.add(GetOrders(username: username));
//    //   yield AuthenticationAuthenticated(username: username);
//    // }
//  }
//}
