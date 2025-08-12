import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_screen.dart';
import 'catalog_screen.dart';
import 'models_screen.dart';
import 'select_models_screen.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({required this.name});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    Color backgroundColor = const Color(0xFFD1495B),
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          shadowColor: Colors.black45,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9DC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C4C2F),
        title: const Text(
          'Tenangos App',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => _logout(context),
          ),
        ],
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Hola, $name!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B2F2F),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color(0xFF8C4C2F),
              thickness: 2,
              endIndent: 200,
            ),
            const SizedBox(height: 40),
            _buildButton(
              context: context,
              text: 'Nuestro catálogo',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CatalogScreen()),
                );
              },
            ),
            const SizedBox(height: 25),
            _buildButton(
              context: context,
              text: 'Nuestros modelos',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ModelsScreen()),
                );
              },
            ),
            const SizedBox(height: 25),
            _buildButton(
              context: context,
              text: 'Crear Pedido',
              backgroundColor: const Color(0xFF5B8E7D),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SelectModelsScreen()),
                );
              },
            ),
            const Spacer(),
            Center(
              child: Text(
                '© 2025 Tenangos',
                style: TextStyle(
                  color: Colors.brown.shade400,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
