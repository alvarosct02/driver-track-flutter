import 'package:flutter/material.dart';
import 'package:driver_track/ui/utils/styles.dart';

class AppLabel extends Text {
  final TextStyle textStyle;
  TextAlign textAlign;

  AppLabel(
    String text, {
    Key key,
    this.textAlign,
    this.textStyle,
  }) : super(text,
            style: textStyle,
            textAlign: textAlign,
            textWidthBasis: TextWidthBasis.parent);
}

class AppText extends StatelessWidget {
  Text label;
  double vSpace;
  double hSpace;
  TextStyle baseStyle;

  String text;
  TextAlign textAlign;
  Color textColor;
  FontWeight textWeight;
  double letterSpacing;
  double opacity;
  int maxLines;
  TextOverflow overflow;

  AppText.label(
      this.text, {
        double size,
        this.vSpace = 0,
        this.hSpace = 0,
        this.textAlign,
        this.textColor,
        this.textWeight,
        this.letterSpacing = 0,
        this.opacity = 1,
        this.maxLines = 1,
        this.overflow = TextOverflow.visible,
      }){
    this.baseStyle = AppTextStyles.body.copyWith(fontSize: size);
  }

  AppText.body(
      this.text, {
        this.vSpace = 0,
        this.hSpace = 0,
        this.textAlign,
        this.textColor,
        this.textWeight,
        this.letterSpacing = 0,
        this.opacity = 1,
        this.maxLines = 1,
        this.overflow = TextOverflow.visible,
      }){
    this.baseStyle = AppTextStyles.body;
  }

  AppText.caption(
      this.text, {
        this.vSpace = 0,
        this.hSpace = 0,
        this.textAlign,
        this.textColor,
        this.textWeight,
        this.letterSpacing = 0,
        this.opacity = 1,
        this.maxLines = 1,
        this.overflow = TextOverflow.visible,
      }){
    this.baseStyle = AppTextStyles.caption;
  }


  AppText.subtitle(
      this.text, {
        this.vSpace = 0,
        this.hSpace = 0,
        this.textAlign,
        this.textColor,
        this.textWeight,
        this.letterSpacing = 0,
        this.opacity = 1,
        this.maxLines = 1,
        this.overflow = TextOverflow.visible,
      }){
    this.baseStyle = AppTextStyles.subtitle;
  }


  AppText.title(
      this.text, {
        this.vSpace = 0,
        this.hSpace = 0,
        this.textAlign,
        this.textColor,
        this.textWeight,
        this.letterSpacing = 0,
        this.opacity = 1,
        this.maxLines = 1,
        this.overflow = TextOverflow.visible,
      }){
    this.baseStyle = AppTextStyles.title;
  }


  AppText.display1(
      this.text, {
        this.vSpace = 0,
        this.hSpace = 0,
        this.textAlign,
        this.textColor,
        this.textWeight,
        this.letterSpacing = 0,
        this.opacity = 1,
        this.maxLines = 1,
        this.overflow = TextOverflow.visible,
      }){
    this.baseStyle = AppTextStyles.display1;
  }


  AppText.display2(
      this.text, {
        this.vSpace = 0,
        this.hSpace = 0,
        this.textAlign,
        this.textColor,
        this.textWeight,
        this.letterSpacing = 0,
        this.opacity = 1,
        this.maxLines = 1,
        this.overflow = TextOverflow.visible,
      }){
    this.baseStyle = AppTextStyles.display2;
  }


  @override
  Widget build(BuildContext context) {

    this.label = Text(text,
        style: baseStyle.copyWith(
          color: (textColor ?? baseStyle.color).withOpacity(opacity),
          fontWeight: textWeight ?? baseStyle.fontWeight,
          letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        textWidthBasis: TextWidthBasis.parent);

    if (vSpace != 0 || hSpace != 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: vSpace, horizontal: hSpace),
        child: label,
      );
    } else {
      return label;
    }
  }
}
