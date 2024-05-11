import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class CustomSlideTransition extends CustomTransitionPage<void> {
//   CustomSlideTransition({super.key, required super.child})
//       : super(
//           transitionDuration: const Duration(milliseconds: 250),
//           transitionsBuilder: (_, animation, __, child) {
//             return SlideTransition(
//               position: animation.drive(
//                 Tween(
//                   begin: const Offset(1.5, 0),
//                   end: Offset.zero,
//                 ).chain(
//                   CurveTween(curve: Curves.ease),
//                 ),
//               ),
//               child: child,
//             );
//           },
//         );
// }

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    // transitionDuration: 1250.ms,
    // reverseTransitionDuration: 1250.ms,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(0, 1.50),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeOut),
          ),
        ),
        child: child,
      ),
    ),
  );
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
  Widget child,
) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithDefaultTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };
