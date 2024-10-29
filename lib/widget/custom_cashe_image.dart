import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCacheImage extends StatefulWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? showBorderRadiusValue;
  final BoxBorder? border;
  final bool showBorder;
  final Color? color;
  final Color? loadingBackgroundColor;
  final BoxFit fit;
  final bool showLogo;
  final List<BoxShadow>? shadow;

  const CustomCacheImage({
    Key? key,
    required this.imageUrl,
    this.height = double.infinity,
    this.shadow,
    this.loadingBackgroundColor,
    this.showBorderRadiusValue,
    this.width=double.infinity,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.borderRadius =  const BorderRadius.all(Radius.circular(6)),
    this.border,
    this.color,
    this.showLogo = false,
    this.fit = BoxFit.cover,
    this.showBorder = false,
  }) : super(key: key);

  @override
  State<CustomCacheImage> createState() => _CustomCacheImageState();
}

class _CustomCacheImageState extends State<CustomCacheImage> {


  @override
  Widget build(BuildContext context) {
    if(widget.imageUrl == null || widget.imageUrl!.isEmpty){
      return  Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          padding: widget.padding,
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: widget.color ?? Colors.grey[100],
            borderRadius:
            widget.borderRadius ?? BorderRadius.circular(100),
            border:  widget.showBorder?Border.all(
              color: Colors.black,
              width: 0.4,
            ):null,
          ),
          child:ClipOval(
            // child: Image.asset(showLogo?AssetsHelper.whiteBodhiLogoOnly:Assets.userPlaceHolder,
            child: Image.asset('assets/logo.png',
              fit: BoxFit.cover,),
          )
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding:widget.padding,
      decoration: BoxDecoration(
        boxShadow: widget.shadow,
        borderRadius:
        widget.borderRadius ?? BorderRadius.circular(8),
        border: widget.showBorder ? widget.border : null,
        color: widget.color??Colors.grey[100],

      ),
      child: CachedNetworkImage(
        key: widget.key,
        imageUrl: widget.imageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius:widget.showBorder? widget.showBorderRadiusValue:
            widget.borderRadius ?? BorderRadius.circular(8),
            color: widget.color??Colors.grey[100],
            image: DecorationImage(
              image: imageProvider,
              fit: widget.fit,
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            border: widget.showBorder ? widget.border : null,
            borderRadius:
            widget.borderRadius ?? BorderRadius.circular(8),
            color: widget.loadingBackgroundColor??widget.color ?? Colors.grey[100],
          ),
          child: const Center(
            child:
            CircularProgressIndicator(strokeWidth: 0.2, color: Colors.black),
          ),
        ),
        errorWidget: (context, url, error){
          return Container(
              width: widget.width,
              height: widget.height,
              margin: widget.margin,
              padding: EdgeInsets.all(widget.showLogo?4:0),
              // padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.color ?? Colors.grey[100],
                borderRadius:
                widget.borderRadius ?? BorderRadius.circular(100),
                border:  widget.showBorder?Border.all(
                  color: Colors.black,
                  width: 0.4,
                ):null,
              ),
              child:ClipOval(
                // child: Image.asset(showLogo?Assets.appIcon:Assets.userPlaceHolder,
                child: Image.asset('assets/logo.png',
                  fit: BoxFit.cover,),
              )
          );
        },
      ),
    );
  }
}