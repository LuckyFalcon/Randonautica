import 'package:flutter/widgets.dart';

import 'Randonaut/RandonautMap.dart';

class Example extends StatefulWidget {
  const Example({Key key, this.foo, this.child}) : super(key: key);

  final Widget child;
  final bool foo;

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: key, child: widget.child);
    print('reachedfor'+widget.foo.toString());
    if (widget.foo) {
      print('reachedt');
      print('reachedt');
      print('reachedt');
      print('reachedt');
      print('createdthis2');
      return Example(child: child);
    }
    print('createdthis');
    return child;
  }
}