import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '/flutter_flow/flutter_flow_animations.dart';

final Map<String, AnimationInfo> animationsMap = {
  'textOnPageLoadAnimation': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: 0.0,
        end: 1.0,
      ),
      MoveEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: const Offset(-60.0, 0.0),
        end: const Offset(0.0, 0.0),
      ),
    ],
  ),
  'columnOnPageLoadAnimation': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: 0.0,
        end: 1.0,
      ),
      MoveEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: const Offset(0.0, 60.0),
        end: const Offset(0.0, 0.0),
      ),
    ],
  ),
  'buttonOnPageLoadAnimation': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: 0.0,
        end: 1.0,
      ),
      MoveEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: const Offset(0.0, 100.0),
        end: const Offset(0.0, 0.0),
      ),
    ],
  ),
};
