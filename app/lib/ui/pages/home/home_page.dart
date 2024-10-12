import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<XFile?> allFiles = [];
  List<AssetEntity> assetEntities = []; // Store asset entities from the gallery

  List<AssetEntity> assetsToDelete = [];

  @override
  Widget build(BuildContext context) {
    Future<void> deletePhotos(List<AssetEntity> assets) async {
      PhotoManager.requestPermissionExtend();
      await PhotoManager.editor
          .deleteWithIds(assets.map((asset) => asset.id).toList());
    }

    Future<void> getImages() async {
      final ImagePicker picker = ImagePicker();
      var response = await picker.pickMultiImage();

      List<AssetEntity> assets = [];
      for (XFile file in response) {
        final List<AssetPathEntity> paths =
            await PhotoManager.getAssetPathList(onlyAll: true);

        for (AssetPathEntity path in paths) {
          List<AssetEntity> entities = await path.getAssetListRange(
            start: 0,
            end: 10000,
          );
          for (AssetEntity entity in entities) {
            File? entityFile = await entity.file;
            print('\n\nentity path: ${entityFile?.path}\n\n');
            print('\n\nfile path: ${file.path}\n\n');
            if (entityFile?.path == file.path) {
              assets.add(entity);
            }
          }
        }
      }

      setState(() {
        // allFiles = response.map((xfile) => File(xfile.path)).toList();
        allFiles = response;
        assetEntities = assets;
      });
    }

    Future<void> deletePhoto(int index) async {
      String filePath = allFiles[index]!.path;
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        debugPrint('photo deleted successfully');
      } else {
        debugPrint('photo does not exist');
      }

      try {
        String assetId = assetEntities[index].id;
        await PhotoManager.editor.deleteWithIds([assetId]);
        debugPrint('Successfully deleted photo');
      } catch (e) {
        debugPrint('Error deleting from gallery: $e');
      }
    }

    var cardItems = allFiles
        .map((e) => Container(
              width: 500,
              height: 500,
              alignment: Alignment.center,
              child: Image.file(File(e!.path)),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImages(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: allFiles.length > 1
                  ? CardSwiper(
                      onSwipe: (index, y, direction) {
                        if (direction == CardSwiperDirection.left) {
                          print('deleting photo');
                          deletePhoto(index);
                        }
                        return true;
                      },
                      allowedSwipeDirection:
                          const AllowedSwipeDirection.symmetric(
                              horizontal: true),
                      cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) =>
                          cardItems[index],
                      cardsCount: allFiles.length)
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
