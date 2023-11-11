import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/ui/ficha/widgets/slide_show.dart';

import 'cubits/slider/slider_cubit.dart';

class SlidesTestPage extends StatelessWidget {
  const SlidesTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final pageController2 = PageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slides Test Page'),
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocProvider(
            create: (context) => SliderCubit(),
            child: Slideshow(
              pageController: pageController,
              slides: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
              ],
            ),
          )),
          ElevatedButton(
            onPressed: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Previous'),
          ),
          ElevatedButton(
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Next'),
          ),
          Expanded(
              child: BlocProvider(
            create: (context) => SliderCubit(),
            child: Slideshow(
              pageController: pageController2,
              slides: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.pink,
                ),
              ],
            ),
          )),
          ElevatedButton(
            onPressed: () {
              pageController2.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Previous'),
          ),
          ElevatedButton(
            onPressed: () {
              pageController2.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class MyCustomButton extends StatelessWidget {
  const MyCustomButton(
      {super.key, required this.pageController, this.onPressed});
  final PageController pageController;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final sliderCubit = BlocProvider.of<SliderCubit>(context);
    final sliderModel = sliderCubit.state.sliderModel;

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (sliderModel.currentPage > 0)
            Expanded(
              child: MaterialButton(
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    sliderCubit.updateCurrentPage(
                      sliderModel.currentPage - 1,
                    );
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
                onPressed: onPressed,
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
  }
}
