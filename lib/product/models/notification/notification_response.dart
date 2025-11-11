import 'package:json_annotation/json_annotation.dart';
part '../_generated/notification/notification_response.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationResponseModel {
  final int? id;
  final String? title;
  final String? message;
  final String? tip;
  final String? kategori;
  final int? count;
  final bool? read;
  final int? referenceId;
  final String? response;
  final bool? processed;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;

  NotificationResponseModel({
    this.id,
    this.title,
    this.message,
    this.tip,
    this.kategori,
    this.count,
    this.read,
    this.referenceId,
    this.response,
    this.processed,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationResponseModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class FieldModel {
  final int? id;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;
  final CityModel? city;
  final DistrictModel? district;
  final String? name;
  final bool? active;
  final bool? otlanma;
  final int? islemSuresi;
  final bool? outline;
  final UserModel? user;

  FieldModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
    this.city,
    this.district,
    this.name,
    this.active,
    this.otlanma,
    this.islemSuresi,
    this.outline,
    this.user,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) =>
      _$FieldModelFromJson(json);
  Map<String, dynamic> toJson() => _$FieldModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CityModel {
  final int? id;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;
  final String? name;

  CityModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
    this.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class DistrictModel {
  final int? id;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;
  final String? name;
  final double? latitude;
  final double? longitude;
  final CityModel? city;

  DistrictModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
    this.name,
    this.latitude,
    this.longitude,
    this.city,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictModelFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class UserModel {
  final int? id;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;
  final String? phone;
  final String? name;
  final String? surname;
  final String? email;
  final String? gender;
  final bool? phoneApproved;
  final String? code;
  final DateTime? codeCreated;
  final String? detailAddress;
  final bool? kvkk;
  final bool? sendAd;
  final CityModel? city;
  final DateTime? birthday;
  final DistrictModel? district;
  final List<RoleModel>? roles;
  final String? fbToken;
  final String? password;
  final bool? enabled;
  final String? username;
  final List<AuthorityModel>? authorities;
  final bool? accountNonLocked;
  final bool? accountNonExpired;
  final bool? credentialsNonExpired;

  UserModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
    this.phone,
    this.name,
    this.surname,
    this.email,
    this.gender,
    this.phoneApproved,
    this.code,
    this.codeCreated,
    this.detailAddress,
    this.kvkk,
    this.sendAd,
    this.city,
    this.birthday,
    this.district,
    this.roles,
    this.fbToken,
    this.password,
    this.enabled,
    this.username,
    this.authorities,
    this.accountNonLocked,
    this.accountNonExpired,
    this.credentialsNonExpired,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RoleModel {
  final int? id;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;
  final String? name;
  final List<PermissionModel>? permissions;

  RoleModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
    this.name,
    this.permissions,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PermissionModel {
  final int? id;
  final bool? deleted;
  final String? createdBy;
  final String? lastUpdatedBy;
  final String? name;

  PermissionModel({
    this.id,
    this.deleted,
    this.createdBy,
    this.lastUpdatedBy,
    this.name,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) =>
      _$PermissionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionModelToJson(this);
}

@JsonSerializable(includeIfNull: false)
class AuthorityModel {
  final String? authority;

  AuthorityModel({this.authority});

  factory AuthorityModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorityModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthorityModelToJson(this);
}
