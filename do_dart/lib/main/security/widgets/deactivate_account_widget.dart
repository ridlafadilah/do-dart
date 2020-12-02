import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';

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
          const Text(
            '''
Once you deactivated account, there is no going back. Please be certain.''',
            style: TextStyle(
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
                child: MaterialButton(
                  color: Colors.red,
                  disabledColor: AppTheme.buttonDisable,
                  minWidth: 200.0,
                  height: 48.0,
                  onPressed: () {},
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Deactivate Account',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
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
}
