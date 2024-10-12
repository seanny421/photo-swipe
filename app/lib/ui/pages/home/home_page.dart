import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<XFile> allFiles = [];
  List<File?> allFiles2 = [];
  List<AssetEntity>? assets = [];

  List<AssetEntity> assetsToDelete = [];

  @override
  Widget build(BuildContext context) {
    Future<void> deletePhotos(List<AssetEntity> assets) async {
      PhotoManager.requestPermissionExtend();
      await PhotoManager.editor
          .deleteWithIds(assets.map((asset) => asset.id).toList());
    }

    Future<void> photoManager() async {
      PhotoManager.setIgnorePermissionCheck(true);
      final List<AssetEntity>? result = await AssetPicker.pickAssets(context);
      final files =
          await Future.wait(result!.map((e) async => await e.file).toList());
      setState(() {
        assets = result;
        allFiles2 = files;
      });
      debugPrint(allFiles2.toString());
    }

    var cardItems = allFiles2
        .map((e) => Container(
              width: 500,
              height: 500,
              alignment: Alignment.center,
              child: Image.file(e!),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => photoManager(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: cardItems.length > 1
                  ? CardSwiper(
                      onSwipe: (index, y, direction) {
                        if (direction == CardSwiperDirection.left) {
                          setState(() {
                            assetsToDelete.add(assets![index]);
                          });
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
            ),
            ElevatedButton(
                onPressed: () => deletePhotos(assetsToDelete),
                child: const Text("DELETE"))
          ],
        ),
      ),
    );
  }
}
