part of 'edit_profile_bloc.dart';

class FullnameChanged extends CommonEvent {
  const FullnameChanged(this.fullname);

  final String fullname;

  @override
  List<String> get props => [fullname];
}

class EmailChanged extends CommonEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<String> get props => [email];
}

class PhoneNumberChanged extends CommonEvent {
  const PhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<String> get props => [phoneNumber];
}

class GenderChanged extends CommonEvent {
  const GenderChanged(this.gender);

  final String gender;

  @override
  List<String> get props => [gender];
}

class PlaceOfBirthChanged extends CommonEvent {
  const PlaceOfBirthChanged(this.placeOfBirth);

  final String placeOfBirth;

  @override
  List<String> get props => [placeOfBirth];
}

class DateOfBirthChanged extends CommonEvent {
  const DateOfBirthChanged(this.dateOfBirth);

  final String dateOfBirth;

  @override
  List<String> get props => [dateOfBirth];
}

class AddressChanged extends CommonEvent {
  const AddressChanged(this.address);

  final String address;

  @override
  List<String> get props => [address];
}

class FetchedEvent extends CommonEvent {
  const FetchedEvent(this.profile);

  final ProfileDto profile;

  @override
  List<ProfileDto> get props => [profile];
}
