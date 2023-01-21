import 'package:flutter/material.dart';
import '../../../constatnts/images.dart';

class FadebleNetworkImage extends StatelessWidget {
  final String _imageUrl;
  double? width;
  double? height;
  String? placeHolderImage;
  String? loadingImage;
  FadebleNetworkImage(this._imageUrl,
      {Key? key,
      this.placeHolderImage,
      this.loadingImage,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Uri.parse(_imageUrl).isAbsolute
        ? FadeInImage.assetNetwork(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            placeholder: loadingImage ?? Images.DEFAULT_LOADING_IMG,
            image: _imageUrl,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) =>
                placeHolderImageBuilder(),
          )
        : placeHolderImageBuilder();
  }

  Image placeHolderImageBuilder() {
    return Image.asset(
      placeHolderImage ?? Images.ZEBAN_GOLDEN_LOGO,
      fit: BoxFit.cover,
    );
  }
}
