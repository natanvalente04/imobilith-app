import 'package:alugueis_app/models/authentication.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/models/usuario_login.dart';

class UsuarioState {
  final List<Usuario> usuarios;
  final Usuario usuario;
  final Authentication auth;
  final UsuarioLogin usuarioLogin;
  final bool isLoggedIn;
  final String result;

  UsuarioState({
    required this.usuarios,
    required this.usuario, 
    required this.usuarioLogin,
    required this.result,
    required this.isLoggedIn,
    required this.auth,
  });

  factory UsuarioState.init(){
    return UsuarioState(usuarios: [], usuario: Usuario.init(), usuarioLogin: UsuarioLogin.init(),auth: Authentication.init(), result: '', isLoggedIn: false);
  }

  UsuarioState copyWith({
    List<Usuario>? usuarios,
    Usuario? usuario,
    UsuarioLogin? usuarioLogin,
    Authentication? auth,
    String? result,
    bool? isLoggedIn,
  })
  {
    return UsuarioState(
      usuarios: usuarios ?? this.usuarios,
      usuario: usuario ?? this.usuario,
      usuarioLogin: usuarioLogin ?? this.usuarioLogin,
      auth: auth ?? this.auth,
      result: result ?? this.result,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}