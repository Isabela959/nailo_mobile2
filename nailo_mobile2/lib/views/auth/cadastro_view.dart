import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nailo_mobile2/views/auth/login_view.dart';
import 'package:nailo_mobile2/models/user.dart';
import 'package:nailo_mobile2/services/usuario_service.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _nomeField = TextEditingController();
  final _emailField = TextEditingController();
  final _telefoneField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();

  bool _ocultarSenha = true;
  bool _ocultarConfirmarSenha = true;

  // método para registrar novo usuário
  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("As senhas devem ser iguais!")),
      );
      return;
    }

    try {
      // cria o usuário no Firebase Auth
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );

      // salva o usuário no Firestore
      final usuario = Usuario(
        id: cred.user!.uid,
        nome: _nomeField.text,
        email: _emailField.text.trim(),
        telefone: _telefoneField.text,
        tipo: "cliente",
        fotoUrl: null,
        ativo: true,
      );

      await UsuarioService.adicionarUsuario(usuario);

      // desloga o usuário recém-criado
      await _auth.signOut();

      // volta pra tela de login
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cadastro realizado com sucesso!")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Registrar: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7E8E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF48CFCB),
        title: const Text("Criar Conta 💅"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeField,
              decoration: const InputDecoration(labelText: "Nome completo"),
            ),
            TextField(
              controller: _emailField,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _telefoneField,
              decoration: const InputDecoration(labelText: "Telefone"),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _ocultarSenha = !_ocultarSenha),
                  icon: Icon(
                    _ocultarSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _ocultarSenha,
            ),
            TextField(
              controller: _confirmarSenhaField,
              decoration: InputDecoration(
                labelText: "Confirmar senha",
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _ocultarConfirmarSenha = !_ocultarConfirmarSenha,
                  ),
                  icon: Icon(
                    _ocultarConfirmarSenha
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: _ocultarConfirmarSenha,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _registrar,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF48CFCB),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Registrar",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              ),
              child: const Text("Já tem uma conta? Faça login"),
            ),
          ],
        ),
      ),
    );
  }
}
