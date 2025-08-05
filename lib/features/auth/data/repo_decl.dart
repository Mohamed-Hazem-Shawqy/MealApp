abstract class RepoDecl {
  Future<void> userLogin(String email, String password, context);
  Future<void> userLoginWithGoogle(context);
  Future<void> userLoginWithFacebook();
}
