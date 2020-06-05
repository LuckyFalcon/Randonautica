import 'package:app/models/page_decoration.dart';
import 'package:flutter/material.dart';

class PageViewModel {
  /// Title of page
  final String title;

  /// Title of page
  final Widget titleWidget;

  /// Text of page (description)
  final Text body;

  /// Text of page (description)
  final Column column;

  /// Widget content of page (description)
  final Widget bodyWidget;

  /// Image of page
  /// Tips: Wrap your image with an alignment widget like Align or Center
  final Widget image;

  /// Footer widget, you can add a button for example
  final Widget footer;

  /// Page decoration
  /// Contain all page customizations, like page color, text styles
  final PageDecoration decoration;

  final Decoration gradientDecoration;

  PageViewModel({
    this.title,
    this.column,
    this.titleWidget,
    this.body,
    this.bodyWidget,
    this.image,
    this.footer,
    this.gradientDecoration,
    this.decoration = const PageDecoration(),
  });
}
