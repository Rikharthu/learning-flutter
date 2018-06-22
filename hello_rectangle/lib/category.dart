import 'package:flutter/material.dart';

// We use an underscore to indicate that these variables are private.
// See https://www.dartlang.org/guides/language/effective-dart/design#libraries
final _rowHeight = 100.0;
final _borderRadius = new BorderRadius.circular(_rowHeight / 2);
final _padding = 8.0;
final _imagePadding = 16.0;
final _textSize = 24.0;
final _imageSize = 60.0;

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.
  const Category({
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        super(key: key);

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Material(
        color: Colors.transparent,
        child: Container(
          height: _rowHeight,
          child: Padding(
            padding: new EdgeInsets.all(_padding),
            child: InkWell(
              splashColor: this.color,
              highlightColor: this.color,
              onTap: () {
                // InkWell will not animate if onTap is null
                print('I was tapped');
              },
              borderRadius: _borderRadius,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // There are two ways to denote a list: `[]` and `List()`.
                // Prefer to use the literal syntax, i.e. `[]`, instead of `List()`.
                // You can add the type argument if you'd like, i.e. <Widget>[].
                // See https://www.dartlang.org/guides/language/effective-dart/usage#do-use-collection-literals-when-possible
                children: <Widget>[
                  Padding(
                    padding: new EdgeInsets.all(_imagePadding),
                    child: Icon(
                      iconLocation,
                      size: _imageSize,
                    ),
                  ),
                  Center(
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: _textSize,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
