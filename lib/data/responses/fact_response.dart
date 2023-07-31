import 'package:json_annotation/json_annotation.dart';

part 'fact_response.g.dart';

@JsonSerializable()
class FactResponse {
  String? text;

  FactResponse(this.text);

  factory FactResponse.fromJson(Map<String, dynamic> json) => _$FactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FactResponseToJson(this);
}
