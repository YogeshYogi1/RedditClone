import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/features/auth/repository/auth_repository.dart';
import 'package:reddit/models/user_model.dart';
import '../../../core/utils.dart';

// This wont work bcoz we only get but we wont edit bcoz its read only widget insted we use userProvider
///final userProvider = Provider((ref) => UserModel(name: name, profilePic: profilePic, banner: banner, uid: uid, isAuthenticated: isAuthenticated, karma: karma, awards: awards));

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController , bool>(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider), ref: ref),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);// loading part

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.failureMsg),
      (r) => _ref.read(userProvider.notifier).update((state) => r),
    );
  }
}
