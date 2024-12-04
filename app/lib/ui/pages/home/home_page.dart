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
              List<Widget> cardItems = viewModel.allFiles
                  .map((e) => Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Image.file(e!),
                      ))
                  .toList();
              return Flexible(
                child: cardItems.length > 1
                    ? CardSwiper(
                        onEnd: () {
                          cardItems.clear();
                        },
                        isLoop: false,
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
                    : viewModel.assetsToDelete.isNotEmpty
                        ? Center(
                            child: ElevatedButton(
                                onPressed: () => print('yo'),
                                child: const Text('Continue')),
                          )
                        : Container(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
