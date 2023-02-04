import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16.0),
            ExpandableContainer(
              isExpanded: _isExpanded,
              child: Container(
                height: 100.0,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: <Widget>[
                    Text(
                      'How to Use The Book Swap',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'This is a sample paragraph.This is a sample paragraph. this is a sample paragraph. this is a sample paragraph',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: _isExpanded ? null : 1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(_isExpanded == true ? 'Collapse' : 'Read More'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primaryContainer),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary)),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool isExpanded;
  final Widget child;

  ExpandableContainer({
    required this.isExpanded,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: Duration(milliseconds: 250),
      // curve: Curves.easeInOut,
      height: isExpanded ? 200.0 : 100.0,
      child: child,
    );
  }
}
