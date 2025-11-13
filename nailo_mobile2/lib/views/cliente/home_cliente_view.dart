import 'package:flutter/material.dart';
import 'package:nailo_mobile2/views/cliente/form_agendamento_view.dart';

class HomeClienteView extends StatelessWidget {
  const HomeClienteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA7E8E4), // Fundo verde água suave
      appBar: AppBar(
        title: const Text(
          "Nailo 💅",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF48CFCB), // Verde Jade
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Olá, seja bem-vinda! 🌸",
              style: TextStyle(
                color: Color(0xFF107A73), // Verde escuro
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Escolha sua profissional favorita abaixo:",
              style: TextStyle(
                color: Color(0xFF107A73),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // Lista de profissionais (mock simples)
            Expanded(
              child: ListView(
                children: [
                  _profissionalCard(
                    context,
                    nome: "Maria Esmalteria",
                    especialidade: "Designer de unhas • Nail Art",
                    foto: "https://i.imgur.com/4YQZ6qC.png",
                  ),
                  _profissionalCard(
                    context,
                    nome: "Joana Spa Nails",
                    especialidade: "Spa dos pés e mãos",
                    foto: "https://i.imgur.com/hO2v6JG.png",
                  ),
                  _profissionalCard(
                    context,
                    nome: "Clara Beauty",
                    especialidade: "Alongamento e blindagem",
                    foto: "https://i.imgur.com/JmP1P5a.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Botão flutuante para novo agendamento
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF48CFCB), // Verde Jade
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormAgendamentoView(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Widget para mostrar cada profissional
  Widget _profissionalCard(BuildContext context,
      {required String nome, required String especialidade, required String foto}) {
    return Card(
      color: const Color(0xFFFAFAFA), // Off White
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(foto),
        ),
        title: Text(
          nome,
          style: const TextStyle(
            color: Color(0xFF107A73),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          especialidade,
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF48CFCB)),
        onTap: () {
          // aqui depois vai abrir o perfil da profissional
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Abrindo perfil de $nome...")),
          );
        },
      ),
    );
  }
}
