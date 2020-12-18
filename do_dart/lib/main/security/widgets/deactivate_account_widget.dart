import 'package:do_dart/main/security/widgets/deactivate_dialog_bottom_sheet.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:do_dart/generated/l10n.dart';

class DeactivateAccountWidget extends StatefulWidget {
  const DeactivateAccountWidget({Key key, this.animationController})
      : super(key: key);

  final AnimationController animationController;

  @override
  _DeactivateAccountWidgetState createState() =>
      _DeactivateAccountWidgetState();
}

class _DeactivateAccountWidgetState extends State<DeactivateAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Text(
            DongkapLocalizations.of(context).deactivateAccountWarning,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                wordSpacing: 1.5,
                height: 1.5),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 2.0),
                  ],
                ),
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 48.0,
                  child: RaisedButton(
                    color: Colors.red,
                    disabledColor: AppTheme.buttonDisable,
                    onPressed: () {
                      _promptDeactivate(context);
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          DongkapLocalizations.of(context).deactivateAccount,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _promptDeactivate(BuildContext context) async {
    await showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return DeactivateDialogBottomSheet(
          onSubmit: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        );
      },
    );
  }
}
