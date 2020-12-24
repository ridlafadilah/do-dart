part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    this.error = '',
    this.status = FormzStatus.pure,
    this.action = FormzStatus.pure,
    this.fullname = const Name.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.gender = const Gender.pure(),
    this.placeOfBirth = const PlaceOfBirth.pure(),
    this.dateOfBirth = const DateOfBirth.pure(),
    this.address = const Address.pure(),
  });

  final String error;
  final FormzStatus status;
  final FormzStatus action;
  final Name fullname;
  final Email email;
  final PhoneNumber phoneNumber;
  final Gender gender;
  final PlaceOfBirth placeOfBirth;
  final DateOfBirth dateOfBirth;
  final Address address;

  EditProfileState copyWith(
      {String error,
      FormzStatus status,
      FormzStatus action,
      Name fullname,
      Email email,
      PhoneNumber phoneNumber,
      Gender gender,
      PlaceOfBirth placeOfBirth,
      DateOfBirth dateOfBirth,
      Address address}) {
    return EditProfileState(
      error: error ?? this.error,
      status: status ?? this.status,
      action: action ?? this.action,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
    );
  }

  @override
  List<Object> get props => [
        status,
        action,
        fullname,
        email,
        phoneNumber,
        gender,
        placeOfBirth,
        dateOfBirth,
        address
      ];
}
