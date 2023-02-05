import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LikedList extends StatefulWidget {
  const LikedList({Key? key}) : super(key: key);

  @override
  State<LikedList> createState() => _LikedListState();
}

class _LikedListState extends State<LikedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // Generated code for this Column Widget...
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: [
                          Image.network(
                            'https://picsum.photos/seed/80/600',
                            width: 100,
                            height: 92,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Book 1 Title\nAuthor',
                            // style: Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children: [
                          Image.network(
                            'https://picsum.photos/seed/80/600',
                            width: 100,
                            height: 92,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'Book 2 Title\nAuthor',
                            // style: TextStyle(Theme.of(context).colorScheme.primaryContainer),
                          ),
                        ],
                      ),
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
