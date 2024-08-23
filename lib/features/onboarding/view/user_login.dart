import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vaani/hacks/fix_autofill_losing_focus.dart';

class UserLogin extends HookConsumerWidget {
  UserLogin({
    super.key,
    this.usernameController,
    this.passwordController,
    this.onPressed,
  });

  TextEditingController? usernameController;
  TextEditingController? passwordController;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    usernameController ??= useTextEditingController();
    passwordController ??= useTextEditingController();
    final isPasswordVisibleAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    var isPasswordVisible = useState(false);

    // forward animation when the password visibility changes
    useEffect(
      () {
        if (isPasswordVisible.value) {
          isPasswordVisibleAnimationController.forward();
        } else {
          isPasswordVisibleAnimationController.reverse();
        }
        return null;
      },
      [isPasswordVisible.value],
    );

    return Center(
      child: InactiveFocusScopeObserver(
        child: AutofillGroup(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameController,
                  autofocus: true,
                  autofillHints: const [AutofillHints.username],
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  obscureText: !isPasswordVisible.value,
                  onFieldSubmitted: onPressed != null
                      ? (_) {
                          onPressed!();
                        }
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        BlendMode.srcIn,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Lottie.asset(
                            'assets/animations/Animation - 1714930099660.json',
                            controller: isPasswordVisibleAnimationController,
                          ),
                        ),
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
