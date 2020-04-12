import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  CustomImage({@required this.url, @required this.width});

  final String url;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      width: width,
      fit: BoxFit.fill,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Container(
                width: width,
                height: width,
                child: CupertinoActivityIndicator());
            break;
          case LoadState.completed:
            return null;
            break;
          case LoadState.failed:
            return GestureDetector(
              child: Container(
                color: Colors.grey,
                width: width,
                height: width,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "load image failed, click to reload",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
          default:
            return Container();
        }
      },
    );
  }
}
