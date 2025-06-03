import 'package:flutter/material.dart';
import 'package:prestonesto/api/api_client.dart';
import 'package:prestonesto/api/auth_api.dart';
import 'package:prestonesto/api/models/user_info.dart';

class ApplicaitonSummaryWidget extends StatefulWidget {
  const ApplicaitonSummaryWidget({Key? key}) : super(key: key);

  @override
  _ApplicaitonSummaryWidgetState createState() => _ApplicaitonSummaryWidgetState();
}

class _ApplicaitonSummaryWidgetState extends State<ApplicaitonSummaryWidget> {
  AuthApi? authApi;
  Future<UserInfo>? _userInfoFuture;

  @override
  void initState() {
    super.initState();
    _initApi();
  }

  Future<void> _initApi() async {
    final apiClient = await ApiClient.create();
    authApi = AuthApi(apiClient);
    setState(() {
      _userInfoFuture = authApi!.fetchMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfo>(
      future: _userInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('No user info found.')),
          );
        }
        final userInfo = snapshot.data!;
        final hasApplied = userInfo.applicationSent &&
            (userInfo.applicationStatus == 'sent' ||
                userInfo.applicationStatus == 'denied');
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: const Text('Aplicación'),
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12.0),
                      child: Text(
                        'Pasos para aplicar',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildStepper(context, userInfo.applicationStatus),
                  const SizedBox(height: 24),
                  _buildComenzarButton(context, hasApplied),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepper(BuildContext context, String status) {
    final steps = [
      'Ingresa tus datos personales',
      'Tomarle foto a tu DNI y una selfie',
      'Elegir un monto y plazo',
      'Fijar tu dirección',
      'Revisar y enviar solicitud',
      'Comprobar tus ingresos',
    ];

    int completedStep = 0;
    switch (status) {
      case 'sent':
        completedStep = 5;
        break;
      case 'approved':
        completedStep = 6;
        break;
      case 'denied':
        completedStep = 5;
        break;
      case 'unsent':
      default:
        completedStep = 0;
    }

    return Column(
      children: List.generate(steps.length, (i) {
        final isCompleted = i < completedStep;
        return Row(
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
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: !isCompleted
                          ? Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 2.0,
                            )
                          : null,
                    ),
                    child: isCompleted
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 8.0,
                          )
                        : null,
                  ),
                  if (i < steps.length - 1)
                    Container(
                      width: 2.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
        );
      }),
    );
  }

  Widget _buildComenzarButton(BuildContext context, bool hasApplied) {
    return ElevatedButton(
      onPressed: () async {
        if (hasApplied) {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('¡Has aplicado en los últimos 3 meses!'),
                content: const Text(
                    'Recuerda que debes esperar 3 meses antes de volver a aplicar a un crédito con nosotros.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
          return;
        }
        Navigator.pushNamed(context, 'Application_Name');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(230.0, 50.0),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48.0),
        ),
        elevation: 3.0,
      ),
      child: Text(
        'Comenzar',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
