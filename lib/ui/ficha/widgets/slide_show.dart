import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/cubits/slider/slider_cubit.dart';

class Slideshow extends StatefulWidget {
  final PageController pageController;
  final List<Widget> slides;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow({
    super.key,
    required this.pageController,
    required this.slides,
    this.bulletPrimario = 15,
    this.bulletSecundario = 12,
  });

  @override
  State<Slideshow> createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  @override
  void initState() {
    super.initState();
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    sliderCubit.updateBulletPrimario(widget.bulletPrimario);
    sliderCubit.updateBulletSecundario(widget.bulletSecundario);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        if (state is SliderChanged) {
          return Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: _Dots(widget.slides.length)),
              Expanded(
                  child: _Slides(
                pageController: widget.pageController,
                slides: widget.slides,
              )),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({
    required this.pageController,
    required this.slides,
  });

  final PageController pageController;
  final List<Widget> slides;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  @override
  void initState() {
    super.initState();

    widget.pageController.addListener(() {
      BlocProvider.of<SliderCubit>(context)
          .updateCurrentPage(widget.pageController.page!.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: PageView(
        controller: widget.pageController,
        children: widget.slides
            .map(
              (slide) => _Slide(slide),
            )
            .toList(),
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
