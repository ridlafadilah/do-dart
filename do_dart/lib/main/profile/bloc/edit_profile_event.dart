part of 'edit_profile_bloc.dart';

class FullnameChanged extends CommonEvent {
  const FullnameChanged(this.fullname);

  final String fullname;

  @override
  List<Object> get props => [fullname];
}

class EmailChanged extends CommonEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PhoneNumberChanged extends CommonEvent {
  const PhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class GenderChanged extends CommonEvent {
  const GenderChanged(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class PlaceOfBirthChanged extends CommonEvent {
  const PlaceOfBirthChanged(this.placeOfBirth);

  final String placeOfBirth;

  @override
  List<Object> get props => [placeOfBirth];
}

class DateOfBirthChanged extends CommonEvent {
  const DateOfBirthChanged(this.dateOfBirth);

  final String dateOfBirth;

  @override
  List<Object> get props => [dateOfBirth];
}

class AddressChanged extends CommonEvent {
  const AddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}
