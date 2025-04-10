import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vaani/api/api_provider.dart';
import 'package:vaani/main.dart';

final httpUrlRegExp = RegExp('https?://');

class AddNewServer extends HookConsumerWidget {
  const AddNewServer({
    super.key,
    this.controller,
    this.onPressed,
    this.readOnly = false,
    this.allowEmpty = false,
  });

  final TextEditingController? controller;

  /// the function to call when the button is pressed
  final void Function()? onPressed;

  /// if this field is read only
  final bool readOnly;

  /// the server URI can be empty
  final bool allowEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myController =
        controller ?? useTextEditingController(text: 'https://');
    var newServerURI = useValueListenable(myController);
    final isServerAlive = ref.watch(isServerAliveProvider(newServerURI.text));
    bool isServerAliveValue = isServerAlive.when(
      data: (value) => value,
      loading: () => false,
      error: (error, _) => false,
    );

    Uri parsedUri = Uri.parse('');

    try {
      parsedUri = Uri.parse(newServerURI.text);
    } on FormatException {
      // prepend https:// if not present
      if (!newServerURI.text.startsWith(httpUrlRegExp)) {
        myController.text = 'https://${newServerURI.text}';
        parsedUri = Uri.parse(myController.text);
      }
    } catch (e) {
      // do nothing
      appLogger.severe('Error parsing URI: $e');
    }
    final canSubmit = !readOnly &&
        (isServerAliveValue || (allowEmpty && newServerURI.text.isEmpty));
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: TextInputType.url,
      autofillHints: const [AutofillHints.url],
      textInputAction: TextInputAction.done,
      onFieldSubmitted: canSubmit
          ? (_) {
              onPressed?.call();
            }
          : null,
      decoration: InputDecoration(
        labelText: 'Server URI',
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
        ),
        border: const OutlineInputBorder(),
        prefixText:
            myController.text.startsWith(httpUrlRegExp) ? '' : 'https://',
        prefixIcon: ServerAliveIcon(server: parsedUri),

        // add server button
        suffixIcon: onPressed == null
            ? null
            : Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: IconButton.filled(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add new server',
                  color: Theme.of(context).colorScheme.inversePrimary,
                  focusColor: Theme.of(context).colorScheme.onSurface,

                  // should be enabled when
                  onPressed: canSubmit
                      ? () {
                          onPressed?.call();
                        }
                      : null, // disable button if server is not alive
                ),
              ),
      ),
    );
    // add to add to existing servers
  }
}

class ServerAliveIcon extends HookConsumerWidget {
  const ServerAliveIcon({
    super.key,
    required this.server,
  });

  final Uri server;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isServerAlive = ref.watch(isServerAliveProvider(server.toString()));
    bool isServerAliveValue = isServerAlive.when(
      data: (value) => value,
      loading: () => false,
      error: (error, _) => false,
    );

    return Tooltip(
      message: server.toString().isEmpty
          ? 'Server Status'
          : isServerAliveValue
              ? 'Server connected'
              : 'Cannot connect to server',
      child: server.toString().isEmpty
          ? Icon(
              Icons.cloud_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            )
          : isServerAlive.when(
              data: (value) {
                return value
                    ? Icon(
                        Icons.cloud_done_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Icon(
                        Icons.cloud_off_outlined,
                        color: Theme.of(context).colorScheme.error,
                      );
              },
              loading: () => Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(),
              ),
              error: (error, _) => Icon(
                Icons.cloud_off_outlined,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
    );
  }
}
