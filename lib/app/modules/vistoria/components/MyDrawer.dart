import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/WELCOME/controllers/welcome_controller.dart';
import 'package:vistoria_mobile/app/routes/app_pages.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Cabeçalho com Avatar
          UserAccountsDrawerHeader(
            accountName: const Text("Nome do Usuário"),
            accountEmail: const Text("email@exemplo.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://www.w3schools.com/howto/img_avatar.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              image: const DecorationImage(
                image: AssetImage('assets/images/drawer_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Lista de opções no Drawer
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navegar para outra tela ou fechar o Drawer
              // Get.toNamed('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              // Navegar para a tela de perfil ou fechar o Drawer
              // Get.toNamed('/perfil');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              // Navegar para a tela de configurações
              Get.toNamed(Routes.CONFIGURACOES);
            },
          ),

          const Spacer(),

          // Botão de logout na parte inferior
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Exibe a caixa de diálogo de confirmação
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmar Logout'),
                    content: const Text('Você realmente deseja sair?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o diálogo
                        },
                      ),
                      TextButton(
                        child: const Text('Sair'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o diálogo
                          WelcomeController.logout(); // Realiza o logout
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
