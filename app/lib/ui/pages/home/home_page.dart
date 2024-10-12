import 'dart:io';

import 'package:app/ui/pages/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomePage(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.pickPhotos(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Observer(builder: (context) {
              var cardItems = viewModel.allFiles
                  .map((e) => Container(
                        width: 500,
                        height: 500,
                        alignment: Alignment.center,
                        child: Image.file(e!),
                      ))
                  .toList();
              return Flexible(
                child: cardItems.length > 1
                    ? CardSwiper(
                        onSwipe: (index, y, direction) {
                          if (direction == CardSwiperDirection.left) {
                            viewModel.assetsToDelete
                                .add(viewModel.assets![index]);
                          }
                          return true;
                        },
                        allowedSwipeDirection:
                            const AllowedSwipeDirection.symmetric(
                                horizontal: true),
                        cardBuilder: (context, index, percentThresholdX,
                                percentThresholdY) =>
                            cardItems[index],
                        cardsCount: cardItems.length)
                    : Container(),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: ElevatedButton(
                  onPressed: () => viewModel.deletePhotos(),
                  child: const Text("DELETE")),
            )
          ],
        ),
      ),
    );
  }
}
