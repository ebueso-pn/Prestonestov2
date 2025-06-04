import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final double height;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool showBackButton;

  const TopBar({
    Key? key,
    required this.title,
    this.onBack,
    this.height = 50.0,
    this.backgroundColor,
    this.actions,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: backgroundColor ?? FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        actions: actions ?? [],
        toolbarHeight: height,
        titleSpacing: 0,
        elevation: 2.0,
        title: Row(
          children: [
            if (onBack != null && showBackButton)
              Container(
                margin: const EdgeInsetsDirectional.only(start: 12.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 36.0,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  onPressed: onBack,
                ),
              ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8.0),
              child: Text(
                title,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Urbanist',
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
