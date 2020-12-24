import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
import 'package:do_dart/main/profile/bloc/edit_profile_bloc.dart';
import 'package:do_dart/l10n/utils/locale_utils.dart';
import 'package:do_theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_dart/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget(
      {Key key,
      this.animationController,
      this.scaffoldMessengerKey,
      this.profile})
      : super(key: key);

  final AnimationController animationController;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final ProfileDto profile;

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EditProfileBloc(
          authService: RepositoryProvider.of<AuthService>(context),
        );
      },
      child: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Flushbar(
              messageText: Text(
                LocaleUtils.translate(state.error),
                style: const TextStyle(color: Colors.white),
              ),
              icon: SvgPicture.asset(
                  'assets/eva_icons/outline/svg/alert-triangle-outline.svg',
                  color: Colors.white),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red[400],
              routeBlur: 0.5,
              isDismissible: false,
              dismissDirection: FlushbarDismissDirection.vertical,
            )..show(context);
          }
        },
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  _FullnameInput(profile: widget.profile),
                  const SizedBox(height: 10),
                  _EmailInput(profile: widget.profile),
                  const SizedBox(height: 10),
                  _PhoneNumberInput(profile: widget.profile),
                  const SizedBox(height: 10),
                  _PlaceOfBirthInput(profile: widget.profile),
                  const SizedBox(height: 10),
                  _DateOfBirthInput(profile: widget.profile),
                  const SizedBox(height: 10),
                  _AddressInput(profile: widget.profile),
                  const SizedBox(height: 10),
                  _ButtonEditProfileInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FullnameInput extends StatefulWidget {
  const _FullnameInput({Key key, this.profile}) : super(key: key);

  final ProfileDto profile;

  @override
  __FullnameInputState createState() => __FullnameInputState();
}

class __FullnameInputState extends State<_FullnameInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.fullname != current.fullname,
      builder: (context, state) {
        return TextFormField(
          key: const Key('editProfileForm_fullname'),
          initialValue: widget.profile.name,
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).fullname,
            hintText: DongkapLocalizations.of(context).fullname,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            errorText: state.fullname.invalid
                ? DongkapLocalizations.of(context).errorFullname
                : null,
          ),
          onChanged: (fullname) =>
              context.read<EditProfileBloc>().add(FullnameChanged(fullname)),
        );
      },
    );
  }
}

class _EmailInput extends StatefulWidget {
  const _EmailInput({Key key, this.profile}) : super(key: key);

  final ProfileDto profile;

  @override
  __EmailInputState createState() => __EmailInputState();
}

class __EmailInputState extends State<_EmailInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('editProfileForm_email'),
          initialValue: widget.profile.email,
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).email,
            hintText: DongkapLocalizations.of(context).email,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            errorText: state.email.invalid
                ? DongkapLocalizations.of(context).errorEmail
                : null,
          ),
          onChanged: (email) =>
              context.read<EditProfileBloc>().add(EmailChanged(email)),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatefulWidget {
  const _PhoneNumberInput({Key key, this.profile}) : super(key: key);

  final ProfileDto profile;

  @override
  __PhoneNumberInputState createState() => __PhoneNumberInputState();
}

class __PhoneNumberInputState extends State<_PhoneNumberInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextFormField(
          key: const Key('editProfileForm_phoneNumber'),
          initialValue: widget.profile.phoneNumber,
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).phoneNumber,
            hintText: DongkapLocalizations.of(context).phoneNumber,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            errorText: state.phoneNumber.invalid
                ? DongkapLocalizations.of(context).errorPhoneNumber
                : null,
          ),
          onChanged: (phoneNumber) => context
              .read<EditProfileBloc>()
              .add(PhoneNumberChanged(phoneNumber)),
        );
      },
    );
  }
}

class _PlaceOfBirthInput extends StatefulWidget {
  const _PlaceOfBirthInput({Key key, this.profile}) : super(key: key);

  final ProfileDto profile;

  @override
  __PlaceOfBirthInputState createState() => __PlaceOfBirthInputState();
}

class __PlaceOfBirthInputState extends State<_PlaceOfBirthInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.placeOfBirth != current.placeOfBirth,
      builder: (context, state) {
        return TextFormField(
          key: const Key('editProfileForm_placeOfBirth'),
          initialValue: widget.profile.placeOfBirth,
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).placeOfBirth,
            hintText: DongkapLocalizations.of(context).placeOfBirth,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            errorText: state.placeOfBirth.invalid
                ? DongkapLocalizations.of(context).errorPlaceOfBirth
                : null,
          ),
          onChanged: (placeOfBirth) => context
              .read<EditProfileBloc>()
              .add(PlaceOfBirthChanged(placeOfBirth)),
        );
      },
    );
  }
}

class _DateOfBirthInput extends StatefulWidget {
  const _DateOfBirthInput({Key key, this.profile}) : super(key: key);

  final ProfileDto profile;

  @override
  __DateOfBirthInputState createState() => __DateOfBirthInputState();
}

class __DateOfBirthInputState extends State<_DateOfBirthInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) {
        return TextFormField(
          key: const Key('editProfileForm_dateOfBirth'),
          initialValue: widget.profile.dateOfBirth,
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).dateOfBirth,
            hintText: DongkapLocalizations.of(context).dateOfBirth,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            errorText: state.dateOfBirth.invalid
                ? DongkapLocalizations.of(context).errorDateOfBirth
                : null,
          ),
          onChanged: (dateOfBirth) => context
              .read<EditProfileBloc>()
              .add(DateOfBirthChanged(dateOfBirth)),
        );
      },
    );
  }
}

class _AddressInput extends StatefulWidget {
  const _AddressInput({Key key, this.profile}) : super(key: key);

  final ProfileDto profile;

  @override
  __AddressInputState createState() => __AddressInputState();
}

class __AddressInputState extends State<_AddressInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return TextFormField(
          key: const Key('editProfileForm_address'),
          initialValue: widget.profile.address,
          autofocus: false,
          decoration: InputDecoration(
            labelText: DongkapLocalizations.of(context).address,
            hintText: DongkapLocalizations.of(context).address,
            contentPadding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            errorText: state.address.invalid
                ? DongkapLocalizations.of(context).errorAddress
                : null,
          ),
          onChanged: (address) =>
              context.read<EditProfileBloc>().add(AddressChanged(address)),
        );
      },
    );
  }
}

class _ButtonEditProfileInput extends StatelessWidget {
  Function _editProfileButtonPress(
      BuildContext context, EditProfileState state) {
    if (!state.action.isValidated || state.status.isSubmissionInProgress) {
      return null;
    } else {
      return () {
        context.read<EditProfileBloc>().add(const SubmittedEvent());
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.action != current.action,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: RaisedButton(
              onPressed: _editProfileButtonPress(context, state),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    DongkapLocalizations.of(context).update,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: (state.status.isSubmissionInProgress ||
                              state.action.isInvalid ||
                              state.action.isPure)
                          ? AppTheme.buttonTextDisable
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.action != current.action,
      builder: (context, state) {
        if (!state.status.isSubmissionInProgress) {
          return const SizedBox(
            height: 4.0,
          );
        } else {
          return const LinearProgressIndicator(
            backgroundColor: AppTheme.colorTheme,
          );
        }
      },
    );
  }
}
