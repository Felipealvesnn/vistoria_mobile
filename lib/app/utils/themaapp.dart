import 'package:flutter/material.dart';

ThemeData ThemaApp() {
  return ThemeData(
    fontFamily: 'Quicksand',
    primarySwatch: Colors.green,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Botões elevados terão a cor verde
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            12.0), // Defina o raio das bordas arredondadas
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            12.0), // Bordas arredondadas quando o campo estiver focado
        borderSide: const BorderSide(
          color: Colors.green, // Cor da borda quando o campo estiver focado
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            12.0), // Bordas arredondadas quando o campo está habilitado
        borderSide: const BorderSide(
          color: Colors.grey, // Cor da borda quando o campo está habilitado
        ),
      ),
    ),
  );
}
