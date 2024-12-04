import 'dart:io';

import 'package:app/helpers/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = AbstractHomeViewModel with _$HomeViewModel;

abstract class AbstractHomeViewModel extends ViewModel with Store {
  AbstractHomeViewModel();

  @observable
  bool isLoading = false;

  @observable
  List<File?> allFiles = [];

  @observable
  List<AssetEntity>? assets = [];

  @observable
  List<AssetEntity> assetsToDelete = [];

  @action
  Future<void> pickPhotos(BuildContext context) async {
    PhotoManager.setIgnorePermissionCheck(true);
    final List<AssetEntity>? result = await AssetPicker.pickAssets(context);
    if (result != null) {
      final files =
          await Future.wait(result.map((e) async => await e.file).toList());
      assets = List.from(result);
      allFiles = List.from(files);
    }
  }

  @action
  Future<void> deletePhotos() async {
    PhotoManager.requestPermissionExtend();
    await PhotoManager.editor
        .deleteWithIds(assetsToDelete.map((asset) => asset.id).toList());
  }
}
