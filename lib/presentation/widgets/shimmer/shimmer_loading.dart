import 'package:flutter/material.dart';

import 'big_shimmer.dart';

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  final bool? isLoading;
  final Widget child;

  @override
  _ShimmerLoadingState createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    print('_ShimmerLoadingState    didChangeDependencies');
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading == true) {
      setState(() {
        print('setState callllllled');
        // update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading == null || widget.isLoading == false) {
      // print('loading finish');
      return widget.child;
    }

    // Collect ancestor shimmer information.
    final shimmer = Shimmer.of(context);
    if (shimmer == null ||
        !shimmer.isSized ||
        context.findRenderObject() == null) {
      //print('shimmer loading false');
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return const SizedBox();
    }
    // print('is load ${widget.isLoading}');
    //print('shimmer loading    ${shimmer.isSized}');
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    print(context.findRenderObject());

    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );
    print('ttttttttttttt');
    print(context.findRenderObject());
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}
