import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart_example/res/components/loading_widget.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  const NetworkImageWidget(
      {Key? key,
      required this.imageUrl,
      this.width = 40,
      this.height = 40,
      this.borderRadius = 18,
      this.iconSize = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl == '' || imageUrl == "null"
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                Icons.person_outline,
                size: iconSize,
              ))
          : CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: LoadingWidget(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color:  Colors.grey,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: iconSize,
                  )),
            ),
    );
  }
}
