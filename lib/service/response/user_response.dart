import 'package:json_annotation/json_annotation.dart';

import '../base_service.dart';

part 'user_response.g.dart';


@JsonSerializable()
class UserResponse implements JsonSerializer {
  final UserInfo? info;
  final List<UserData?>? results;

  UserResponse({this.info, this.results});

  @override
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return _$UserResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserResponseToJson(this);
  }
}

@JsonSerializable()
class UserInfo implements JsonSerializer {
  final int? page;
  final int? results;
  final String? seed;
  final String? version;

  UserInfo({this.page, this.results, this.seed, this.version});

  @override
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return _$UserInfoFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserInfoToJson(this);
  }
}

@JsonSerializable()
class UserData implements JsonSerializer {
  final String? cell;
  final UserDob? dob;
  final String? email;
  final String? gender;
  final UserId? id;
  final UserLogin? login;
  final UserName? name;
  final String? nat;
  final String? phone;
  final UserPicture? picture;
  final UserRegistered? registered;

  UserData({
    this.cell,
    this.dob,
    this.email,
    this.gender,
    this.id,
    this.login,
    this.name,
    this.nat,
    this.phone,
    this.picture,
    this.registered,
  });

  @override
  factory UserData.fromJson(Map<String, dynamic> json) {
    return _$UserDataFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserDataToJson(this);
  }
}

@JsonSerializable()
class UserDob implements JsonSerializer {
  final int? age;
  final String? date;

  UserDob({this.age, this.date});

  @override
  factory UserDob.fromJson(Map<String, dynamic> json) {
    return _$UserDobFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserDobToJson(this);
  }
}

@JsonSerializable()
class UserId implements JsonSerializer {
  final String? name;
  final String? value;

  UserId({this.name, this.value});

  @override
  factory UserId.fromJson(Map<String, dynamic> json) {
    return _$UserIdFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserIdToJson(this);
  }
}

@JsonSerializable()
class UserCoordinates implements JsonSerializer {
  final String? latitude;
  final String? longitude;

  UserCoordinates({this.latitude, this.longitude});

  @override
  factory UserCoordinates.fromJson(Map<String, dynamic> json) {
    return _$UserCoordinatesFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserCoordinatesToJson(this);
  }
}

@JsonSerializable()
class UserStreet implements JsonSerializer {
  final String? name;
  final int? number;

  UserStreet({this.name, this.number});

  @override
  factory UserStreet.fromJson(Map<String, dynamic> json) {
    return _$UserStreetFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserStreetToJson(this);
  }
}

@JsonSerializable()
class UserTimezone implements JsonSerializer {
  final String? description;
  final String? offset;

  UserTimezone({this.description, this.offset});

  @override
  factory UserTimezone.fromJson(Map<String, dynamic> json) {
    return _$UserTimezoneFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserTimezoneToJson(this);
  }
}

@JsonSerializable()
class UserLogin implements JsonSerializer {
  final String? md5;
  final String? password;
  final String? salt;
  final String? sha1;
  final String? sha256;
  final String? username;
  final String? uuid;

  UserLogin({
    this.md5,
    this.password,
    this.salt,
    this.sha1,
    this.sha256,
    this.username,
    this.uuid,
  });

  @override
  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return _$UserLoginFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserLoginToJson(this);
  }
}

@JsonSerializable()
class UserName implements JsonSerializer {
  final String? title;
  final String? first;
  final String? last;

  UserName({this.title, this.first, this.last});

  @override
  factory UserName.fromJson(Map<String, dynamic> json) {
    return _$UserNameFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserNameToJson(this);
  }
}

@JsonSerializable()
class UserPicture implements JsonSerializer {
  final String? large;
  final String? medium;
  final String? thumbnail;

  UserPicture({this.large, this.medium, this.thumbnail});

  @override
  factory UserPicture.fromJson(Map<String, dynamic> json) {
    return _$UserPictureFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserPictureToJson(this);
  }
}

@JsonSerializable()
class UserRegistered implements JsonSerializer {
  final int? age;
  final String? date;

  UserRegistered({this.age, this.date});

  @override
  factory UserRegistered.fromJson(Map<String, dynamic> json) {
    return _$UserRegisteredFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserRegisteredToJson(this);
  }
}