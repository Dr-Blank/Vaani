import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/features/onboarding/providers/oauth_provider.dart';
import 'package:vaani/features/onboarding/view/user_login_with_password.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/router/router.dart';

class CallbackPage extends HookConsumerWidget {
  CallbackPage({super.key, this.state, this.code});

  final String? state;
  final String? code;

  final serverErrorResponse = ErrorResponseHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state == null || code == null) {
      return _SomethingWentWrong(
        message:
            'OAuth callback missing state or code\nGot: State: $state, Code: $code',
      );
    }

    final flows = ref.read(oauthFlowsProvider);

    // check if the state is in the flows
    if (!flows.containsKey(state)) {
      return const _SomethingWentWrong(
        message: 'State not found',
      );
    }

    // get the token
    final loginAuthToken = ref.watch(
      loginInExchangeForCodeProvider(
        oauthState: state!,
        code: code!,
        responseHandler: serverErrorResponse,
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contacting server...\nPlease wait\n\nGot:'
                '\nState: $state\nCode: $code'),
            loginAuthToken.when(
              data: (authenticationToken) {
                if (authenticationToken == null) {
                  handleServerError(
                    context,
                    serverErrorResponse,
                  );
                  return const BackToLoginButton();
                }
                return Text('Token: $authenticationToken');
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) {
                handleServerError(
                  context,
                  serverErrorResponse,
                  e: error,
                );
                return Column(
                  children: [
                    Text('Error with OAuth flow: $error'),
                    const BackToLoginButton(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        GoRouter.of(context).goNamed(Routes.onboarding.name);
      },
      child: const Text('Return to login'),
    );
  }
}

class _SomethingWentWrong extends StatelessWidget {
  const _SomethingWentWrong({
    super.key,
    this.message = 'Error with OAuth flow',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const BackToLoginButton(),
          ],
        ),
      ),
    );
  }
}
