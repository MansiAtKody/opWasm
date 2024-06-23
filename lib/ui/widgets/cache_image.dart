import 'package:cached_network_image/cached_network_image.dart';
import 'package:kody_operator/ui/utils/const/app_constants.dart';
import 'package:kody_operator/ui/utils/helpers/base_widget.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class CacheImage extends StatelessWidget with BaseStatelessWidget {
  final String imageURL;
  final double? height;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final double? width;
  final bool? setPlaceHolder;
  final String? placeholderImage;
  final BoxFit? contentMode;

  const CacheImage({Key? key, required this.imageURL, this.height, this.width, this.setPlaceHolder = true, this.placeholderImage, this.contentMode, this.bottomLeftRadius, this.bottomRightRadius, this.topLeftRadius, this.topRightRadius})
      : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return (imageURL == '')
        ? placeHolderWidget()
        : CachedNetworkImage(
            imageUrl: imageURL,
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(topLeftRadius ?? 0.0), topRight: Radius.circular(topRightRadius ?? 0.0), bottomRight: Radius.circular(bottomRightRadius ?? 0.0), bottomLeft: Radius.circular(bottomLeftRadius ?? 0.0)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: contentMode ?? BoxFit.fill,
                  // colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                ),
              ),
            ),
            placeholder: (context, url) {
              return placeHolderWidget();
            },
            errorWidget: (context, url, error) => placeHolderWidget(),
          );
  }

  Widget placeHolderWidget() {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Text(
          appName[0],
          style: TextStyles.semiBold.copyWith(fontSize: 18),
        ),
      ),
    );
    // return Image.asset(
    //   placeholderImage ?? AppAssets.icPlaceholder,
    //   /*?? icAppIcon*/
    //   height: height,
    //   width: width,
    // );
  }
}
