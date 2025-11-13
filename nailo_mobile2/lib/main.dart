import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nailo_mobile2/firebase_options.dart';
import 'package:nailo_mobile2/views/auth/login_view.dart';
import 'package:nailo_mobile2/views/cliente/home_cliente_view.dart';
import 'package:nailo_mobile2/views/components/navbar_cliente.dart';

void main() async {
  // Garante o carregamento dos widgets antes do Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as opções automáticas
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Executa o app
  runApp(const NailoApp());
}

class NailoApp extends StatelessWidget {
  const NailoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nailo 💅",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFA7E8E4),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF48CFCB),
          foregroundColor: Colors.white,
        ),
        brightness: Brightness.light,
      ),
      home: const AuthStream(),
    );
  }
}

class AuthStream extends StatefulWidget {
  const AuthStream({super.key});

  @override
  State<AuthStream> createState() => _AuthStreamState();
}

class _AuthStreamState extends State<AuthStream> {
  @override
  Widget build(BuildContext context) {
    // StreamBuilder -> muda automaticamente entre login e home
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Se o usuário estiver logado → vai pra HomeClienteView
        if (snapshot.hasData) {
          return const NavbarCliente();
        }
        // Caso contrário → vai pra LoginView
        return const LoginView();
      },
    );
  }
}
