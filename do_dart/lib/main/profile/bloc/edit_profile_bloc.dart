import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<CommonEvent, EditProfileState> {
  EditProfileBloc({@required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(const EditProfileState());

  final AuthService _authService;

  @override
  Stream<EditProfileState> mapEventToState(
    CommonEvent event,
  ) async* {
    if (event is SubmittedEvent) {
      yield* _mapEditProfileSubmittedToState(event, state);
    } else {
      yield _mapEventToState(event, state);
    }
  }

  EditProfileState _mapEventToState(
    CommonEvent event,
    EditProfileState state,
  ) {
    Name fullname = state.fullname;
    Email email = state.email;
    PhoneNumber phoneNumber = state.phoneNumber;
    Gender gender = state.gender;
    PlaceOfBirth placeOfBirth = state.placeOfBirth;
    DateOfBirth dateOfBirth = state.dateOfBirth;
    Address address = state.address;
    if (event is FullnameChanged) {
      fullname = Name.dirty(event.fullname);
    } else if (event is EmailChanged) {
      email = Email.dirty(event.email);
    } else if (event is PhoneNumberChanged) {
      phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    } else if (event is GenderChanged) {
      gender = Gender.dirty(event.gender);
    } else if (event is PlaceOfBirthChanged) {
      placeOfBirth = PlaceOfBirth.dirty(event.placeOfBirth);
    } else if (event is DateOfBirthChanged) {
      dateOfBirth = DateOfBirth.dirty(event.dateOfBirth);
    } else if (event is AddressChanged) {
      address = Address.dirty(event.address);
    }
    return state.copyWith(
      fullname: fullname,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      placeOfBirth: placeOfBirth,
      dateOfBirth: dateOfBirth,
      address: address,
      action: Formz.validate([
        fullname,
        email,
        phoneNumber,
        gender,
        placeOfBirth,
        dateOfBirth,
        address
      ]),
    );
  }

  Stream<EditProfileState> _mapEditProfileSubmittedToState(
    SubmittedEvent event,
    EditProfileState state,
  ) async* {
    if (state.action.isValidated) {
      yield state.copyWith(
          status: FormzStatus.submissionInProgress,
          action: FormzStatus.submissionInProgress);
      try {
        ProfileService profileService =
            ProfileService(authService: _authService);
        await profileService.getProfile();
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on ServerError catch (err) {
        yield state.copyWith(
            error: err.getErrorMessage(),
            status: FormzStatus.submissionFailure);
      }
    }
  }
}
