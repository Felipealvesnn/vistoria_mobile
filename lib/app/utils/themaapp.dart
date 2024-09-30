import 'package:flutter/material.dart';

ThemeData ThemaApp() {
  return ThemeData(
    fontFamily: 'Quicksand',
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    dividerTheme: const DividerThemeData(
      space: 0,
      thickness: 1,
      color: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
            Colors.white), // Define a cor da label
        backgroundColor: WidgetStateProperty.all<Color>(
            Colors.green), // Cor de fundo do botão
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 16), // Tamanho do texto
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: Colors.black, // Cor do label
      ),
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
