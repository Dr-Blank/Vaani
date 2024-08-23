import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:whispering_pages/api/api_provider.dart';

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
    final myController = controller ?? useTextEditingController();
    var newServerURI = useValueListenable(myController);
    final isServerAlive = ref.watch(isServerAliveProvider(newServerURI.text));
    bool isServerAliveValue = isServerAlive.when(
      data: (value) => value,
      loading: () => false,
      error: (error, _) => false,
    );

    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: TextInputType.url,
      autofillHints: const [AutofillHints.url],
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Server URI',
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
        ),
        border: const OutlineInputBorder(),
        prefixText: 'https://',
        prefixIcon: Tooltip(
          message: newServerURI.text.isEmpty
              ? 'Server Status'
              : isServerAliveValue
                  ? 'Server connected'
                  : 'Cannot connect to server',
          child: newServerURI.text.isEmpty
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
        ),

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
                  onPressed: !readOnly &&
                          (isServerAliveValue ||
                              (allowEmpty && newServerURI.text.isEmpty))
                      ? onPressed
                      : null, // disable button if server is not alive
                ),
              ),
      ),
    );
    // add to add to existing servers
  }
}
