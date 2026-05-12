import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

import '../errors/error_model.dart';

class ErrorDialog extends HookWidget {
  final String title;
  final ErrorModel error;
  final VoidCallback onDismiss;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.error,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final pulseController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    final pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
    );

    final scaleController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut),
    );

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: scaleController, curve: Curves.easeOut));

    useEffect(() {
      scaleController.forward();
      return null;
    }, []);

    return AnimatedBuilder(
      animation: scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Center(
                child: ErrorDialogContainer(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                        child: ErrorDialogContent(
                          title: title,
                          error: error,
                          pulseAnimation: pulseAnimation,
                        ),
                      ),
                      ErrorDialogActionButton(
                        onPressed: () {
                          pulseController.stop();
                          scaleController.reverse().then((_) {
                            onDismiss();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ErrorDialogContainer extends StatelessWidget {
  final Widget child;

  const ErrorDialogContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness;
    final backgroundColor =
        (brightness == Brightness.dark
                ? const Color(0xFF2C2C2E)
                : CupertinoColors.systemBackground)
            .withValues(alpha: 0.85);

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: child,
        ),
      ),
    );
  }
}

class ErrorDialogContent extends StatelessWidget {
  final String title;
  final ErrorModel error;
  final Animation<double> pulseAnimation;

  const ErrorDialogContent({
    super.key,
    required this.title,
    required this.error,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness;
    final titleColor = brightness == Brightness.dark
        ? CupertinoColors.white
        : CupertinoColors.black;
    final messageColor = brightness == Brightness.dark
        ? CupertinoColors.systemGrey
        : CupertinoColors.systemGrey2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: pulseAnimation.value,
              child: ErrorDialogIcon(icon: error.icon),
            );
          },
        ),
        const Gap(20),
        Text(
          title,
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
              .copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
          textAlign: TextAlign.center,
        ),
        const Gap(12),
        Text(
          error.message,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: messageColor,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        if (error.errors?.isNotEmpty == true) ...[
          const Gap(12),
          ErrorDialogDetails(errors: error.errors!),
        ],
      ],
    );
  }
}

class ErrorDialogIcon extends StatelessWidget {
  final IconData? icon;

  const ErrorDialogIcon({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: CupertinoColors.systemRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Icon(
        icon ?? CupertinoIcons.exclamationmark_triangle_fill,
        size: 32,
        color: CupertinoColors.systemRed,
      ),
    );
  }
}

class ErrorDialogDetails extends StatelessWidget {
  final List<String> errors;

  const ErrorDialogDetails({super.key, required this.errors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CupertinoColors.systemRed.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: CupertinoColors.systemRed.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Text(
        errors.join('\n'),
        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: 12,
          color: CupertinoColors.systemRed,
          height: 1.3,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ErrorDialogActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ErrorDialogActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.of(context).brightness;
    final separatorColor = brightness == Brightness.dark
        ? CupertinoColors.separator.darkColor
        : CupertinoColors.separator;

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: separatorColor, width: 0.5)),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 16),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
        onPressed: onPressed,
        child: Text(
          'OK',
          style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.activeBlue,
          ),
        ),
      ),
    );
  }
}
