import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool disabled;
  final bool loading;

  final Color? backgroundColor;
  final Color? color;
  final BorderRadius borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool noShadow;

  final IconData? leading;
  final IconData? trailing;

  const Button(
      {super.key,
      required this.text,
      required this.onTap,
      this.backgroundColor,
      this.color,
      this.borderRadius = const BorderRadius.all(Radius.circular(35.0)),
      this.disabled = false,
      this.loading = false,
      this.noShadow = false,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0.0,
      this.leading,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? Theme.of(context).colorScheme.onPrimary;

    return Container(
      decoration: BoxDecoration(
        boxShadow: noShadow
            ? const []
            : const [
                BoxShadow(
                  color: Color(0x29000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        borderRadius: borderRadius,
        color: disabled
            ? Theme.of(context).disabledColor
            : backgroundColor ?? Theme.of(context).primaryColor,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          splashColor: disabled ? Colors.transparent : null,
          highlightColor: disabled ? Colors.transparent : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: borderColor,
                width: borderWidth,
              ),
            ),
            child: Center(
              child: loading
                  ? SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.onPrimary)),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null)
                          Icon(
                            leading,
                            color: textColor,
                            size: 16,
                          ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(text,
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700))),
                        if (trailing != null)
                          Icon(
                            trailing,
                            color: textColor,
                            size: 16,
                          ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
