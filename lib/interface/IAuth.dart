abstract class IAuth {
  Future<String> authenticationWithEmailAndPass(
      {required String email, required String password});
  Future<String> authenticationWithGoogle({required dynamic credentials});
  Future<String> authenticationWithFacebook({required dynamic credentials});
}
