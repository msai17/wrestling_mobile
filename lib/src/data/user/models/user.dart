import 'package:wrestling_hub/src/domain/user/entity/user_entity.dart';

class User extends UserEntity {


  User({
    super.id,
    super.status,
    super.token,
    super.phoneNumber,
    super.firstName,
    super.lastName,
    super.lastVisit,
    super.creationDateTime,
    super.patronymic,
    super.avatars,
    super.email
  });

  User.fromJson(Map<String, dynamic> data) {
    id = data['id'] ?? '';
    status = data['status'] ?? '';
    token = data['token'] ?? '';
    phoneNumber = data['phone_number'] ?? '';
    firstName = data['first_name'] ?? '';
    lastName = data['last_name'] ?? '';
    lastVisit = data['last_visit'] ?? '';
    creationDateTime = data['creation_date_time'] ?? '';
    patronymic = data['patronymic'] ?? '';
    avatars = data['avatars'] ?? '';
    email = data['email'] ?? '';
  }

  String getInitials() {
    String initials = '';
    if (lastName!.isNotEmpty) {
      initials += '$lastName ';
    }
    if (firstName!.isNotEmpty) {
      initials += '${firstName![0].toUpperCase()}.';
    }
    if (patronymic!.isNotEmpty) {
      initials += '${patronymic![0].toUpperCase()}.';
    }
    return initials;
  }





}