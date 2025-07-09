import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      elevation: elevation ?? 2,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      margin: margin ?? EdgeInsets.zero,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: card,
      );
    }

    return card;
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final List<Color>? colors;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.colors,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColors = [
      Theme.of(context).primaryColor,
      Theme.of(context).colorScheme.secondary,
    ];

    return Container(
      width: width,
      height: height ?? 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? defaultColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: Container(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            alignment: Alignment.center,
            child: Text(
              text,
              style:
                  textStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;

  const LoadingWidget({super.key, this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(message!, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ],
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
        ],
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
        if (action != null) ...[const SizedBox(height: 24), action!],
      ],
    );
  }
}
