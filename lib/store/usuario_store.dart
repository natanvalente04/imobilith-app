import 'package:alugueis_app/models/authentication.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/models/usuario_login.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:alugueis_app/repositories/usuario_login_repository.dart';
import 'package:alugueis_app/repositories/usuario_repository.dart';
import 'package:alugueis_app/states/usuario_state.dart';
import 'package:flutter/widgets.dart';

class UsuarioStore extends ValueNotifier<UsuarioState>{
  final repository = UsuarioRepository();
  final loginRepository = UsuarioLoginRepository();
  UsuarioStore() : super(UsuarioState.init());

  Future<bool> existeUsuario() async {
    final existe = await repository.existeUsuario();
    return existe;
  }

  Future<bool> existeUsuarioByPessoaId(int codPessoa) async{
    final existe = await repository.existeUsuarioByPessoaId(codPessoa);
    return existe;
  }

  Future<void> Login(UsuarioLogin login) async {
    Authentication auth = await loginRepository.Login(login); 
    await TokenStorage.saveToken(auth);
    value = value.copyWith(isLoggedIn: await TokenStorage.isLoggedIn());
  }
  
  Future<void> getUsuarios() async {
    List<Usuario> usuarios = await repository.getUsuarios();
    value = value.copyWith(usuarios: usuarios);
  }

  Future<void> addUsuario(Usuario usuario) async {
    final usuarioNovo = await repository.addUsuario(usuario);
    value = value.copyWith(
      usuarios: [...value.usuarios, usuarioNovo]
    );
  }

  Future<void> deleteUsuario(int codUsuario) async {
    await repository.deleteUsuario(codUsuario);
    getUsuarios();
  }

  Future<void> updateUsuario(Usuario usuarioAtualizado) async {
    await repository.updateUsuario(usuarioAtualizado);
    getUsuarios();
  }
}