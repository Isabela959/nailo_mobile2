import 'package:flutter/material.dart';
import 'package:nailo_mobile2/views/cliente/agenda_cliente_view.dart';
import 'package:nailo_mobile2/views/cliente/historico_cliente_view.dart';
import 'package:nailo_mobile2/views/cliente/home_cliente_view.dart';
import 'package:nailo_mobile2/views/cliente/agenda_cliente_view.dart';
import 'package:nailo_mobile2/views/cliente/historico_cliente_view.dart';
import 'package:nailo_mobile2/views/cliente/perfil_cliente_view.dart';

class NavbarCliente extends StatefulWidget {
  const NavbarCliente({super.key});

  @override
  State<NavbarCliente> createState() => _NavbarClienteState();
}

class _NavbarClienteState extends State<NavbarCliente> {
  int _paginaAtual = 0;

  final List<Widget> _paginas = const [
    HomeClienteView(),
    AgendaClienteView(),
    HistoricoClienteView(),
    PerfilClienteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_paginaAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: (index) {
          setState(() {
            _paginaAtual = index;
          });
        },
        backgroundColor: const Color(0xFF48CFCB),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF107A73),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Agenda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Histórico",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
