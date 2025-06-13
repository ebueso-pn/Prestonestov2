import 'package:flutter/material.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_theme.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_widgets.dart';
import 'package:prestonesto/shared/services/models/user_info.dart';
import '/services/auth_service.dart';

import '/flutter_flow/flutter_flow_util.dart';

import 'widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _trySignInIfNeeded();
  }

  Future<void> _trySignInIfNeeded() async {
    if (FFAppState().currentUser == null) {
      final result = await AuthService.signInWithTokens();
      if (result['success'] == true && result['user'] != null) {
        setState(() {
          FFAppState().currentUser = result['user'];
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = FFAppState().currentUser;
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (userInfo == null) {
      Future.microtask(() {
        context.goNamed('Onboarding');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final hasApplied = hasUserApplied(userInfo);
    final currentStep = getUserCurrentStep(userInfo);

    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          extendBodyBehindAppBar: false,
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        'Pasos para aplicar',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    _buildStepper(context, currentStep),
                    const SizedBox(height: 24),
                    // Button moved to bottomNavigationBar
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
            child: _buildComenzarButton(context, currentStep, hasApplied),
          ),
        ));
  }

  Widget _buildStepper(BuildContext context, int currentStep) {
    final steps = [
      'Ingresa tus datos personales',
      'Tomarle foto a tu DNI y una selfie',
      'Elegir un monto y plazo',
      'Fijar tu dirección',
      'Poner tu ubicación en el mapa',
      'Comprobar tus ingresos',
      'Revisar y enviar solicitud',
    ];

    return Column(
      children: List.generate(steps.length, (i) {
        final isCompleted = i < currentStep;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 16.0,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryBackground,
                        shape: BoxShape.circle,
                        border: !isCompleted
                            ? Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 2.0,
                              )
                            : null,
                      ),
                      child: isCompleted
                          ? Icon(
                              Icons.check,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 8.0,
                            )
                          : null,
                    ),
                    if (i < steps.length - 1)
                      Container(
                        width: 2.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .primary
                              .withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.85 - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      steps[i],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildComenzarButton(
      BuildContext context, int currentStep, bool hasApplied) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
      child: FFButtonWidget(
        onPressed: () async {
          if (hasApplied) {
            await showDialog(
              context: context,
              builder: (alertDialogContext) => const AlreadyAppliedDialog(),
            );
            return;
          }
          context.goNamedAuth(getRouteForStep(currentStep), context.mounted);
        },
        text: currentStep == 0 ? 'Comenzar' : 'Continuar',
        options: FFButtonOptions(
          width: 270.0,
          height: 50.0,
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                fontFamily: 'Urbanist',
                color: FlutterFlowTheme.of(context).secondaryBackground,
                fontSize: 16.0,
              ),
          elevation: 3.0,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(48.0),
        ),
      ),
    );
  }

  String getRouteForStep(int step) {
    print("El baile del beeper");
    print(step);
    switch (step) {
      case -1:
        return 'UnableToApply';
      case 0:
        return 'BasicInformation';
      case 1:
        return 'KYCValidation';
      case 2:
        return 'Calculator';
      case 3:
        return 'Address';
      case 4:
        return 'Map';
      case 5:
        return 'Documents';
      case 6:
        return 'ReviewApplication';
      default:
        return 'Application_Name';
    }
  }

  bool hasUserApplied(dynamic user) {
    if (user == null) return false;

    return false;

    final lastApplicationDate = user['lastApplicationDate'];
    if (lastApplicationDate == null) return false;

    final threeMonthsAgo = DateTime.now().subtract(const Duration(days: 90));
    return lastApplicationDate.isAfter(threeMonthsAgo);
  }

  int getUserCurrentStep(UserInfo user) {
    print(user);
    if (!user.hasFinancials) return 0;

    if (user.hasFinancials && !user.hasKYC) return 1;

    if (user.hasKYC && user.hasKYC && !user.isKYCValid) {
      return -1;
    }

    if (user.isKYCValid && user.isAppParamsMissing) {
      return 1;
    }

    if (user.isAppParamsMissing) {
      return 2;
    }

    if (!user.hasLocation) {
      return 3;
    }

    if (!user.hasLocationPoint) {
      return 4;
    }

    if (!user.hasIncomeFileUploaded) {
      return 5;
    }

    return 6;
  }
}
