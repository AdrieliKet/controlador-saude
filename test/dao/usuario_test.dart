import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:saude_tech/app/database/dao/usuario_dao.dart';

import 'package:saude_tech/app/domain/entities/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  UsuarioDao usuarioDao;
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  setUp(() {
    usuarioDao = const UsuarioDao();
  });

  tearDown(() async {
    String path = join(await getDatabasesPath(), 'banco.db');
    deleteDatabase(path); // irá excluir o banco - não use na produção
  });

  test("Persistir no banco de dados um usuário", () async {
    var usuario = Usuario(
        nome: "adrieli",
        email: "adrieli@gmail.com",
        senha: "adrieli1010",
        telefone: "44999999999",
        cpf: "122.999.666-99");
    var resultado = await usuarioDao.salvar(usuario);
    expect(resultado, true);
  });

  test("Alterar um registro de um usuário do banco", () async {
    var usuario = Usuario(
        id: 1,
        nome: "Adrieli Kethin dos Santos",
        email: "adrielikethin@gmail.com",
        senha: "1010adrieli",
        telefone: "44888888888",
        cpf: "122.999.666-99");
    var resultado = await usuarioDao.alterar(usuario);
    expect(resultado, true);
  });

  test("Listar todos os usuários", () async {
    var resultado = await usuarioDao.listarTodos();
    expect(resultado, isInstanceOf<List<Usuario>>());
  });

  test('teste excluir usuário', () async {
    var resultado = await usuarioDao.excluir(1);
    expect(resultado, true);
  });
}
