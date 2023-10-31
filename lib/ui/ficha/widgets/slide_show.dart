import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/cubits/slider/slider_cubit.dart';

class Slideshow extends StatelessWidget {
  final PageController pageViewController;
  final List<Widget> slides;
  final bool puntosArriba;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow(
      {super.key,
      required this.pageViewController,
      required this.slides,
      this.puntosArriba = false,
      this.bulletPrimario = 15,
      this.bulletSecundario = 12});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Perform initialization here
        final sliderCubit = SliderCubit();
        // You can initialize values or perform other setup tasks here
        sliderCubit.updateBulletPrimario(bulletPrimario);
        sliderCubit.updateBulletSecundario(bulletSecundario);
        return sliderCubit;
      },
      child: BlocBuilder<SliderCubit, SliderState>(
        builder: (context, state) {
          if (state is SliderChanged) {
            return Column(
              children: [
                if (puntosArriba)
                  Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: _Dots(slides.length)),
                Expanded(
                    child: _Slides(
                  slides: slides,
                  pageViewController: pageViewController,
                )),
                if (!puntosArriba) _Dots(slides.length),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({required this.slides, required this.pageViewController});
  final List<Widget> slides;
  final PageController pageViewController;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  @override
  void initState() {
    final sliderCubit = BlocProvider.of<SliderCubit>(context, listen: false);

    super.initState();
    widget.pageViewController.addListener(() {
      sliderCubit.updateCurrentPage(widget.pageViewController.page!);
    });
  }

  @override
  void dispose() {
    widget.pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: widget.pageViewController,
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
    return SizedBox(
        width: double.infinity,
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

    final pageViewIndex = slideCubit.sliderModel.currentPage;
    final lowerBound = index - 0.5;
    final upperBound = index + 0.5;

    Color color;
    double tamano = 0.0;

    if (pageViewIndex >= lowerBound && pageViewIndex < upperBound) {
      color = Colors.green;
      tamano = slideCubit.sliderModel.bulletPrimario;
    } else {
      color = Colors.grey;
      tamano = slideCubit.sliderModel.bulletSecundario;
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
