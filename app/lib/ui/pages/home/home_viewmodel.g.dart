// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on AbstractHomeViewModel, Store {
  late final _$isLoadingAtom =
      Atom(name: 'AbstractHomeViewModel.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$allFilesAtom =
      Atom(name: 'AbstractHomeViewModel.allFiles', context: context);

  @override
  List<File?> get allFiles {
    _$allFilesAtom.reportRead();
    return super.allFiles;
  }

  @override
  set allFiles(List<File?> value) {
    _$allFilesAtom.reportWrite(value, super.allFiles, () {
      super.allFiles = value;
    });
  }

  late final _$assetsAtom =
      Atom(name: 'AbstractHomeViewModel.assets', context: context);

  @override
  List<AssetEntity>? get assets {
    _$assetsAtom.reportRead();
    return super.assets;
  }

  @override
  set assets(List<AssetEntity>? value) {
    _$assetsAtom.reportWrite(value, super.assets, () {
      super.assets = value;
    });
  }

  late final _$assetsToDeleteAtom =
      Atom(name: 'AbstractHomeViewModel.assetsToDelete', context: context);

  @override
  List<AssetEntity> get assetsToDelete {
    _$assetsToDeleteAtom.reportRead();
    return super.assetsToDelete;
  }

  @override
  set assetsToDelete(List<AssetEntity> value) {
    _$assetsToDeleteAtom.reportWrite(value, super.assetsToDelete, () {
      super.assetsToDelete = value;
    });
  }

  late final _$pickPhotosAsyncAction =
      AsyncAction('AbstractHomeViewModel.pickPhotos', context: context);

  @override
  Future<void> pickPhotos(BuildContext context) {
    return _$pickPhotosAsyncAction.run(() => super.pickPhotos(context));
  }

  late final _$deletePhotosAsyncAction =
      AsyncAction('AbstractHomeViewModel.deletePhotos', context: context);

  @override
  Future<void> deletePhotos() {
    return _$deletePhotosAsyncAction.run(() => super.deletePhotos());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
allFiles: ${allFiles},
assets: ${assets},
assetsToDelete: ${assetsToDelete}
    ''';
  }
}
