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
          return _Slides(
            pageController: widget.pageController,
            slides: widget.slides,
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
      padding: const EdgeInsets.all(20),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
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
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: child,
    );
  }
}
