import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '/flutter_flow/flutter_flow_animations.dart';

const List<String> hondurasDepartments = [
  'Francisco Morazán',
  'Cortés',
  'Yoro',
  'Atlántida',
  'Olancho',
  'Choluteca',
  'Comayagua',
  'El Paraíso',
  'Santa Bárbara',
  'Intibucá',
  'La Paz',
  'Lempira',
  'Copán',
  'Valle',
  'Ocotepeque',
  'Gracias a Dios',
  'Islas de la Bahía',
  'Colon'
];

final animationsMap = {
  'columnOnPageLoadAnimation': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: 0,
        end: 1,
      ),
      MoveEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: Offset(0, 60),
        end: Offset(0, 0),
      ),
    ],
  ),
  'rowOnPageLoadAnimation': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: 0,
        end: 1,
      ),
      MoveEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: Offset(-60, 0),
        end: Offset(0, 0),
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
        begin: 0,
        end: 1,
      ),
      MoveEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 600.ms,
        begin: Offset(0, 100),
        end: Offset(0, 0),
      ),
    ],
  ),
};
