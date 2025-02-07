import 'package:json_annotation/json_annotation.dart';
part '../_generated/notification/notification_request.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationRequestModel {
  int? id;
  bool? allowNotifications;
  bool? allowSms;
  bool? allowEmail;

  NotificationRequestModel({
    this.id,
    this.allowNotifications,
    this.allowSms,
    this.allowEmail,
  });

  factory NotificationRequestModel.fromJson(Map<String, dynamic> json) => _$NotificationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestModelToJson(this);
}
