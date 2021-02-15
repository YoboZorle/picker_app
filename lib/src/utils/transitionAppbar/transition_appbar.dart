import 'package:flutter/material.dart';

class TransitionAppBar extends StatelessWidget {
  final Widget avatar;
  final Widget title;
  final double extent;

  TransitionAppBar({this.avatar, this.title, this.extent = 250, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar,
          title: title,
          extent: extent > 200 ? extent : 200
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 70, left: 30),
      end: EdgeInsets.only(left: 0.0, top: 30.0));
  final _avatarAlignTween =
  AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topCenter);

  final Widget avatar;
  final Widget title;
  final double extent;

  _TransitionAppBarDelegate({this.avatar, this.title, this.extent = 250})
      : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: shrinkOffset * 2,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Colors.white,
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
              alignment: avatarAlign,
              child: avatar
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: title,
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => (maxExtent * 68) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}

class WalletAppBar extends StatelessWidget {
  final Widget child;

  WalletAppBar({this.child});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _WalletAppBarDelegate(child: child),
    );
  }
}

class _WalletAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 70, left: 30),
      end: EdgeInsets.only(left: 0.0, top: 30.0));
  final _avatarAlignTween =
  AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topCenter);

  final Widget child;

  _WalletAppBarDelegate({this.child})
      : assert(child != null);

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: shrinkOffset * 2,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Colors.white,
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
              alignment: avatarAlign,
              child: child
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => (maxExtent * 68) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return true;
  }
}
