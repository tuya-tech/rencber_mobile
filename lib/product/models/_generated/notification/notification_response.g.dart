// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../notification/notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseModel _$NotificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    NotificationResponseModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      islemTipi: json['islemTipi'] as String?,
      count: (json['count'] as num?)?.toInt(),
      field: json['field'] == null
          ? null
          : FieldModel.fromJson(json['field'] as Map<String, dynamic>),
      read: json['read'] as bool?,
    );

Map<String, dynamic> _$NotificationResponseModelToJson(
        NotificationResponseModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.islemTipi case final value?) 'islemTipi': value,
      if (instance.count case final value?) 'count': value,
      if (instance.field case final value?) 'field': value,
      if (instance.read case final value?) 'read': value,
    };

FieldModel _$FieldModelFromJson(Map<String, dynamic> json) => FieldModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      name: json['name'] as String?,
      active: json['active'] as bool?,
      otlanma: json['otlanma'] as bool?,
      islemSuresi: (json['islemSuresi'] as num?)?.toInt(),
      outline: json['outline'] as bool?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FieldModelToJson(FieldModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.city case final value?) 'city': value,
      if (instance.district case final value?) 'district': value,
      if (instance.name case final value?) 'name': value,
      if (instance.active case final value?) 'active': value,
      if (instance.otlanma case final value?) 'otlanma': value,
      if (instance.islemSuresi case final value?) 'islemSuresi': value,
      if (instance.outline case final value?) 'outline': value,
      if (instance.user case final value?) 'user': value,
    };

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.name case final value?) 'name': value,
    };

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) =>
    DistrictModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      name: json['name'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.name case final value?) 'name': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.city case final value?) 'city': value,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phoneApproved: json['phoneApproved'] as bool?,
      code: json['code'] as String?,
      codeCreated: json['codeCreated'] == null
          ? null
          : DateTime.parse(json['codeCreated'] as String),
      detailAddress: json['detailAddress'] as String?,
      kvkk: json['kvkk'] as bool?,
      sendAd: json['sendAd'] as bool?,
      city: json['city'] == null
          ? null
          : CityModel.fromJson(json['city'] as Map<String, dynamic>),
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      district: json['district'] == null
          ? null
          : DistrictModel.fromJson(json['district'] as Map<String, dynamic>),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fbToken: json['fbToken'] as String?,
      password: json['password'] as String?,
      enabled: json['enabled'] as bool?,
      username: json['username'] as String?,
      authorities: (json['authorities'] as List<dynamic>?)
          ?.map((e) => AuthorityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      accountNonLocked: json['accountNonLocked'] as bool?,
      accountNonExpired: json['accountNonExpired'] as bool?,
      credentialsNonExpired: json['credentialsNonExpired'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.name case final value?) 'name': value,
      if (instance.surname case final value?) 'surname': value,
      if (instance.email case final value?) 'email': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.phoneApproved case final value?) 'phoneApproved': value,
      if (instance.code case final value?) 'code': value,
      if (instance.codeCreated?.toIso8601String() case final value?)
        'codeCreated': value,
      if (instance.detailAddress case final value?) 'detailAddress': value,
      if (instance.kvkk case final value?) 'kvkk': value,
      if (instance.sendAd case final value?) 'sendAd': value,
      if (instance.city case final value?) 'city': value,
      if (instance.birthday?.toIso8601String() case final value?)
        'birthday': value,
      if (instance.district case final value?) 'district': value,
      if (instance.roles case final value?) 'roles': value,
      if (instance.fbToken case final value?) 'fbToken': value,
      if (instance.password case final value?) 'password': value,
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.username case final value?) 'username': value,
      if (instance.authorities case final value?) 'authorities': value,
      if (instance.accountNonLocked case final value?)
        'accountNonLocked': value,
      if (instance.accountNonExpired case final value?)
        'accountNonExpired': value,
      if (instance.credentialsNonExpired case final value?)
        'credentialsNonExpired': value,
    };

RoleModel _$RoleModelFromJson(Map<String, dynamic> json) => RoleModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      name: json['name'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => PermissionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoleModelToJson(RoleModel instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.name case final value?) 'name': value,
      if (instance.permissions case final value?) 'permissions': value,
    };

PermissionModel _$PermissionModelFromJson(Map<String, dynamic> json) =>
    PermissionModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool?,
      createdBy: json['createdBy'] as String?,
      lastUpdatedBy: json['lastUpdatedBy'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PermissionModelToJson(PermissionModel instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.deleted case final value?) 'deleted': value,
      if (instance.createdBy case final value?) 'createdBy': value,
      if (instance.lastUpdatedBy case final value?) 'lastUpdatedBy': value,
      if (instance.name case final value?) 'name': value,
    };

AuthorityModel _$AuthorityModelFromJson(Map<String, dynamic> json) =>
    AuthorityModel(
      authority: json['authority'] as String?,
    );

Map<String, dynamic> _$AuthorityModelToJson(AuthorityModel instance) =>
    <String, dynamic>{
      if (instance.authority case final value?) 'authority': value,
    };
