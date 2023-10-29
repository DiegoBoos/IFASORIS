import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/cubits/slider/slider_cubit.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow(
      {super.key,
      required this.slides,
      this.puntosArriba = false,
      this.bulletPrimario = 15,
      this.bulletSecundario = 12});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SliderCubit(),
      child: SafeArea(
        child: Builder(
          builder: (context) {
            final sliderCubit = BlocProvider.of<SliderCubit>(context);
            sliderCubit.updateBulletPrimatio(bulletPrimario);
            sliderCubit.updateBulletSecundatio(bulletSecundario);

            return Center(
              child: Column(
                children: [
                  if (puntosArriba) _Dots(slides.length),
                  Expanded(child: _Slides(slides: slides)),
                  if (!puntosArriba) _Dots(slides.length),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({required this.slides});
  final List<Widget> slides;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    final sliderCubit = BlocProvider.of<SliderCubit>(context, listen: false);

    super.initState();
    pageViewController.addListener(() {
      sliderCubit.updateCurrentPage(pageViewController.page!);
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots(this.length);

  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 70,
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(length, (index) => _Dot(index)),
        ));
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final slideCubit = BlocProvider.of<SliderCubit>(context).state;

    final pageViewIndex = slideCubit.currentPage;
    final lowerBound = index - 0.5;
    final upperBound = index + 0.5;

    Color color;
    double tamano = 0.0;

    if ((pageViewIndex >= lowerBound && pageViewIndex < upperBound)) {
      color = Colors.blue;
      tamano = slideCubit.bulletPrimario;
    } else {
      color = Colors.grey;
      tamano = slideCubit.bulletSecundario;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: tamano,
      height: tamano,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
