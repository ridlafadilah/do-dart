import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonList extends StatefulWidget {
  const SkeletonList(
      {Key key,
      this.index,
      this.heightLeading = 40,
      this.widthLeading = 40,
      this.heightTitle = 14.0,
      this.widthTitle = 200.0,
      this.heightSubtitle = 12.0,
      this.widthSubtitle = 100.0,
      this.horizontalGap = 10.0,
      this.marginItem = const EdgeInsets.only(bottom: 31.5),
      this.marginTitle = const EdgeInsets.only(bottom: 7)})
      : super(key: key);

  final int index;
  final double heightLeading;
  final double widthLeading;
  final double heightTitle;
  final double widthTitle;
  final double heightSubtitle;
  final double widthSubtitle;
  final double horizontalGap;
  final EdgeInsets marginItem;
  final EdgeInsets marginTitle;

  @override
  createState() => SkeletonListState();
}

class SkeletonListState extends State<SkeletonList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.white,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: widget.widthLeading,
                  height: widget.heightLeading,
                  margin: widget.marginItem,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.widthLeading / 2)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: widget.horizontalGap),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: widget.widthTitle,
                      height: widget.heightTitle,
                      color: Colors.white,
                      margin: widget.marginTitle,
                    ),
                    Container(
                      width: widget.widthSubtitle,
                      height: widget.heightSubtitle,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
