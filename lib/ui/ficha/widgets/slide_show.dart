import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/cubits/slider/slider_cubit.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final double bulletPrimario;
  final double bulletSecundario;
  final Function()? onSlideChanged;

  const Slideshow({
    super.key,
    required this.slides,
    this.puntosArriba = false,
    this.bulletPrimario = 15,
    this.bulletSecundario = 12,
    this.onSlideChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    sliderCubit.updateBulletPrimario(bulletPrimario);
    sliderCubit.updateBulletSecundario(bulletSecundario);

    return BlocBuilder<SliderCubit, SliderState>(
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
                onSlideChanged: onSlideChanged,
              )),
              if (!puntosArriba) _Dots(slides.length),
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
  const _Slides({required this.slides, required this.onSlideChanged});
  final List<Widget> slides;
  final Function()? onSlideChanged;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    sliderCubit.updatePageController(_pageController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: widget.slides
            .map(
              (slide) => Column(
                children: [
                  Expanded(flex: 1, child: _Slide(slide)),
                  Expanded(
                    flex: 0,
                    child: SliderActions(
                      onSlideChanged: widget.onSlideChanged,
                      slidesLength: widget.slides.length,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class SliderActions extends StatelessWidget {
  const SliderActions({
    required this.onSlideChanged,
    required this.slidesLength,
    super.key,
  });

  final Function()? onSlideChanged;
  final int slidesLength;

  @override
  Widget build(BuildContext context) {
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    final currentPage = sliderCubit.state.sliderModel.currentPage;
    final bool lastPage = currentPage == slidesLength - 1;

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (currentPage > 0)
            Expanded(
              child: MaterialButton(
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    sliderCubit.updateCurrentPage(currentPage - 1);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text(
                        'Anterior',
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: MaterialButton(
                disabledColor: Colors.grey,
                elevation: 0,
                color: Theme.of(context).colorScheme.primary,
                onPressed: onSlideChanged,
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      lastPage ? 'Finalizar' : 'Siguiente',
                      style: const TextStyle(color: Colors.white),
                    ))),
          ),
        ],
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
