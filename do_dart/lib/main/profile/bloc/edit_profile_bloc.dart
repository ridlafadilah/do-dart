import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_core/core.dart';
import 'package:do_core/models.dart';
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
    } else if (event is FetchedEvent) {
      yield _mapFetchedEventToState(event, state);
    } else {
      yield _mapEventToState(event, state);
    }
  }

  EditProfileState _mapFetchedEventToState(
    FetchedEvent event,
    EditProfileState state,
  ) {
    final Name fullname = Name.pure(event.profile.name);
    final Email email = Email.pure(event.profile.email);
    final PhoneNumber phoneNumber = PhoneNumber.pure(event.profile.phoneNumber);
    final Gender gender = Gender.pure(event.profile.genderCode);
    final PlaceOfBirth placeOfBirth =
        PlaceOfBirth.pure(event.profile.placeOfBirth);
    final DateOfBirth dateOfBirth = DateOfBirth.pure(event.profile.dateOfBirth);
    final Address address = Address.pure(event.profile.address);
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
      status: FormzStatus.pure,
      error: null,
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
        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          action: FormzStatus.submissionSuccess,
          error: null,
        );
      } on ServerError catch (err) {
        yield state.copyWith(
          error: err.getErrorMessage(),
          action: FormzStatus.submissionFailure,
          status: FormzStatus.submissionFailure,
        );
      }
    }
  }
}
