// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      info: json['info'] == null
          ? null
          : UserInfo.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      page: (json['page'] as num?)?.toInt(),
      results: (json['results'] as num?)?.toInt(),
      seed: json['seed'] as String?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'seed': instance.seed,
      'version': instance.version,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      cell: json['cell'] as String?,
      dob: json['dob'] == null
          ? null
          : UserDob.fromJson(json['dob'] as Map<String, dynamic>),
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      id: json['id'] == null
          ? null
          : UserId.fromJson(json['id'] as Map<String, dynamic>),
      login: json['login'] == null
          ? null
          : UserLogin.fromJson(json['login'] as Map<String, dynamic>),
      name: json['name'] == null
          ? null
          : UserName.fromJson(json['name'] as Map<String, dynamic>),
      nat: json['nat'] as String?,
      phone: json['phone'] as String?,
      picture: json['picture'] == null
          ? null
          : UserPicture.fromJson(json['picture'] as Map<String, dynamic>),
      registered: json['registered'] == null
          ? null
          : UserRegistered.fromJson(json['registered'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'cell': instance.cell,
      'dob': instance.dob,
      'email': instance.email,
      'gender': instance.gender,
      'id': instance.id,
      'login': instance.login,
      'name': instance.name,
      'nat': instance.nat,
      'phone': instance.phone,
      'picture': instance.picture,
      'registered': instance.registered,
    };

UserDob _$UserDobFromJson(Map<String, dynamic> json) => UserDob(
      age: (json['age'] as num?)?.toInt(),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$UserDobToJson(UserDob instance) => <String, dynamic>{
      'age': instance.age,
      'date': instance.date,
    };

UserId _$UserIdFromJson(Map<String, dynamic> json) => UserId(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$UserIdToJson(UserId instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

UserCoordinates _$UserCoordinatesFromJson(Map<String, dynamic> json) =>
    UserCoordinates(
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$UserCoordinatesToJson(UserCoordinates instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

UserStreet _$UserStreetFromJson(Map<String, dynamic> json) => UserStreet(
      name: json['name'] as String?,
      number: (json['number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserStreetToJson(UserStreet instance) =>
    <String, dynamic>{
      'name': instance.name,
      'number': instance.number,
    };

UserTimezone _$UserTimezoneFromJson(Map<String, dynamic> json) => UserTimezone(
      description: json['description'] as String?,
      offset: json['offset'] as String?,
    );

Map<String, dynamic> _$UserTimezoneToJson(UserTimezone instance) =>
    <String, dynamic>{
      'description': instance.description,
      'offset': instance.offset,
    };

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) => UserLogin(
      md5: json['md5'] as String?,
      password: json['password'] as String?,
      salt: json['salt'] as String?,
      sha1: json['sha1'] as String?,
      sha256: json['sha256'] as String?,
      username: json['username'] as String?,
      uuid: json['uuid'] as String?,
    );

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      'md5': instance.md5,
      'password': instance.password,
      'salt': instance.salt,
      'sha1': instance.sha1,
      'sha256': instance.sha256,
      'username': instance.username,
      'uuid': instance.uuid,
    };

UserName _$UserNameFromJson(Map<String, dynamic> json) => UserName(
      title: json['title'] as String?,
      first: json['first'] as String?,
      last: json['last'] as String?,
    );

Map<String, dynamic> _$UserNameToJson(UserName instance) => <String, dynamic>{
      'title': instance.title,
      'first': instance.first,
      'last': instance.last,
    };

UserPicture _$UserPictureFromJson(Map<String, dynamic> json) => UserPicture(
      large: json['large'] as String?,
      medium: json['medium'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$UserPictureToJson(UserPicture instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'thumbnail': instance.thumbnail,
    };

UserRegistered _$UserRegisteredFromJson(Map<String, dynamic> json) =>
    UserRegistered(
      age: (json['age'] as num?)?.toInt(),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$UserRegisteredToJson(UserRegistered instance) =>
    <String, dynamic>{
      'age': instance.age,
      'date': instance.date,
    };
