
abstract class RepoDecl {

  Future<void>userLogin(String email,String password);
  Future<void>userLoginWithGoogle();
  Future<void>userLoginWithFacebook();
}