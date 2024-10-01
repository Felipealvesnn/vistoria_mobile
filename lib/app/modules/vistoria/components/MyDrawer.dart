import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistoria_mobile/app/modules/WELCOME/controllers/welcome_controller.dart';

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
            //  Get.toNamed('/configuracoes');
            },
          ),
          
          const Spacer(),

          // Botão de logout na parte inferior
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Lógica para realizar logout e redirecionar para tela de login
             WelcomeController.logout();
            },
          ),
        ],
      ),
    );
  }
}
