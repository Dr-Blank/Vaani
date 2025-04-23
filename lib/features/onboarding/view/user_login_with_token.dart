import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shelfsdk/audiobookshelf_api.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/api/authenticated_users_provider.dart';
import 'package:vaani/models/error_response.dart';
import 'package:vaani/router/router.dart';
import 'package:vaani/settings/models/models.dart' as model;

class UserLoginWithToken extends HookConsumerWidget {
  UserLoginWithToken({
    super.key,
    required this.server,
    required this.addServer,
    this.onSuccess,
  });

  final Uri server;
  final model.AudiobookShelfServer Function() addServer;
  final serverErrorResponse = ErrorResponseHandler();
  final Function(model.AuthenticatedUser)? onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authTokensController = useTextEditingController();

    final api = ref.watch(audiobookshelfApiProvider(server));
    Future<void> loginAndSave() async {
      api.token = authTokensController.text;
      model.AuthenticatedUser? authenticatedUser;
      LoginResponse? success;
      try {
        success = await api.misc.authorize(
          responseErrorHandler: serverErrorResponse.storeError,
        );
        if (success == null) {
          throw StateError('No response from server');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed. Got response: ${serverErrorResponse.response.body} (${serverErrorResponse.response.statusCode})',
            ),
            action: SnackBarAction(
              label: 'See Error',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(e.toString()),
                  ),
                );
              },
            ),
          ),
        );
        return;
      }
      authenticatedUser = model.AuthenticatedUser(
        server: addServer(),
        id: success.user.id,
        username: success.user.username,
        authToken: api.token!,
      );

      if (onSuccess != null) {
        onSuccess!(authenticatedUser);
      } else {
        ref
            .read(authenticatedUsersProvider.notifier)
            .addUser(authenticatedUser, setActive: true);
        context.goNamed(Routes.home.name);
      }
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: authTokensController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            maxLines: 10,
            minLines: 1,
            decoration: InputDecoration(
              labelText: 'API Token',
              labelStyle: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.8),
              ),
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an API token';
              }
              return null;
            },
            onFieldSubmitted: (_) async {
              await loginAndSave();
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: loginAndSave,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
