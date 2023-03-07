import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
    final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children:  [
          const _ContenedorMorado(),
          const HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ContenedorMorado extends StatelessWidget {
  const _ContenedorMorado();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: _decoracionDeLaCajaMorada(),
      child: Stack(
        children: [
          Positioned(
              top: 10,
              left: (MediaQuery.of(context).size.width * 0.7),
              child: const _Burbuja()),
          Positioned(
              top: 40,
              left: (MediaQuery.of(context).size.width * 0.2),
              child: const _Burbuja()),
          Positioned(
              bottom: 10,
              left: (MediaQuery.of(context).size.width * 0.8),
              child: const _Burbuja()),
          Positioned(
              bottom: 10,
              left: (MediaQuery.of(context).size.width * 0.2),
              child: const _Burbuja()),
          Positioned(
              bottom: (MediaQuery.of(context).size.width * 0.25),
              right: (MediaQuery.of(context).size.width * 0.8),
              child: const _Burbuja()),
          Positioned(
              bottom: (MediaQuery.of(context).size.width * 0.25),
              left: (MediaQuery.of(context).size.width * 0.5),
              child: const _Burbuja()),
        ],
      ),
    );
  }

  BoxDecoration _decoracionDeLaCajaMorada() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1),
    ]));
  }
}

class _Burbuja extends StatelessWidget {
  const _Burbuja();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(122, 255, 255, 0.05),
      ),
    );
  }
}
