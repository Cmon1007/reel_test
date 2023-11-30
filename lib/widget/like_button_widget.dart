import 'package:flutter/material.dart';
import 'package:shorts_video_player/widget/like_action_wdiget.dart';

class LikeButtonWidet extends StatefulWidget {
  final bool isLiked;
  const LikeButtonWidet({
    this.isLiked = false,
    super.key,
  });

  @override
  State<LikeButtonWidet> createState() => _CommentLikeButtonWidetState();
}

class _CommentLikeButtonWidetState extends State<LikeButtonWidet> {
  final ValueNotifier<bool> _isLiked = ValueNotifier<bool>(false);

  @override
  void initState() {
    _isLiked.value = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLiked,
      builder: (_, isLiked, __) {
        return InkWell(
          onTap: () {
            _isLiked.value = !isLiked;
          },
          child: LikeActionWidget(
            iconUrl: isLiked ? Icons.favorite : Icons.favorite_outline,
            backgroundColor: Colors.transparent,
            iconColor: isLiked ? Colors.red : Colors.white,
          ),
        );
      },
    );
  }
}
