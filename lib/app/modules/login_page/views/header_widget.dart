import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final IconData _icon;

  const HeaderWidget(this._height, this._showIcon, this._icon, {super.key});

  @override
  _HeaderWidgetState createState() =>
      _HeaderWidgetState(_height, _showIcon, _icon);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final double _height;
  final bool _showIcon;
  final IconData _icon;

  _HeaderWidgetState(this._height, this._showIcon, this._icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Cores dos gradientes
    Color primaryColor = Get.theme.primaryColor;
    Color VerdeEscuro = const Color.fromARGB(255, 16, 68, 20);

    return Stack(
      children: [
        // Primeira camada (mais ao fundo)

        _buildClipPath(
          width,
          _height,
          [
            Offset(width / 5, _height),
            Offset(width / 10 * 5, _height - 60),
            Offset(width / 5 * 4, _height + 20),
            Offset(width, _height - 18),
          ],
          [primaryColor.withOpacity(0.9), VerdeEscuro],
          const [0.0, 1.0],
        ),
        // Segunda camada (intermediária)
        _buildClipPath(
          width,
          _height,
          [
            Offset(width / 3, _height + 20),
            Offset(width / 10 * 8, _height - 60),
            Offset(width / 5 * 4, _height - 60),
            Offset(width, _height - 20),
          ],
          [primaryColor, VerdeEscuro],
          const [0.0, 1.0],
        ),
        // Terceira camada (mais à frente)
        _buildClipPath(
          width,
          _height,
          [
            Offset(width / 5, _height),
            Offset(width / 2, _height - 40),
            Offset(width / 5 * 4, _height - 80),
            Offset(width, _height - 20),
          ],
          [primaryColor, VerdeEscuro],
          const [0.0, 1.0],
        ),
        // Ícone de overlay (opcional)
        if (_showIcon)
          SizedBox(
            height: _height,
            child: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 50, bottom: 70.0),
                child: Image.asset('assets/icon/icon.png'),
              ),
            ),
          ),
      ],
    );
  }

  // Função auxiliar para criar cada camada de gradiente com recorte
  Widget _buildClipPath(double width, double height, List<Offset> offsets,
      List<Color> colors, List<double> stops) {
    return ClipPath(
      clipper: ShapeClipper(offsets),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: stops,
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }
}

// Clipper personalizado para criar formas complexas
class ShapeClipper extends CustomClipper<Path> {
  final List<Offset> offsets;
  ShapeClipper(this.offsets);

  @override
  Path getClip(Size size) {
    var path = Path();

    // Define os pontos iniciais do caminho
    path.lineTo(0.0, size.height - 20);

    // Cria curvas com base nos offsets fornecidos
    path.quadraticBezierTo(
        offsets[0].dx, offsets[0].dy, offsets[1].dx, offsets[1].dy);
    path.quadraticBezierTo(
        offsets[2].dx, offsets[2].dy, offsets[3].dx, offsets[3].dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
