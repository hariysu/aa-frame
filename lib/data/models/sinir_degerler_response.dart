import 'package:json_annotation/json_annotation.dart';

part 'sinir_degerler_response.g.dart';

@JsonSerializable()
class SinirDegerlerResponse {
  @JsonKey(name: 'EsikDeger_Madde13Alt')
  final int esikDegerMadde13Alt;

  @JsonKey(name: 'EsikDeger_Madde13Orta')
  final int esikDegerMadde13Orta;

  @JsonKey(name: 'EsikDeger_Madde13Ust')
  final int esikDegerMadde13Ust;

  @JsonKey(name: 'EsikDeger_Madde8GenelButceMalHizmet')
  final int esikDegerMadde8GenelButceMalHizmet;

  @JsonKey(name: 'EsikDeger_Madde8KITMalHizmet')
  final int esikDegerMadde8KITMalHizmet;

  @JsonKey(name: 'EsikDeger_Madde8Yapim')
  final int esikDegerMadde8Yapim;

  @JsonKey(name: 'Sikayet_1')
  final int sikayet1;

  @JsonKey(name: 'Sikayet_1_Bedel')
  final int sikayet1Bedel;

  @JsonKey(name: 'Sikayet_2')
  final int sikayet2;

  @JsonKey(name: 'Sikayet_2_Bedel')
  final int sikayet2Bedel;

  @JsonKey(name: 'Sikayet_3')
  final int sikayet3;

  @JsonKey(name: 'Sikayet_3_Bedel')
  final int sikayet3Bedel;

  @JsonKey(name: 'Sikayet_4_Bedel')
  final int sikayet4Bedel;

  @JsonKey(name: 'Sonuc')
  final SonucModel sonuc;

  SinirDegerlerResponse({
    required this.esikDegerMadde13Alt,
    required this.esikDegerMadde13Orta,
    required this.esikDegerMadde13Ust,
    required this.esikDegerMadde8GenelButceMalHizmet,
    required this.esikDegerMadde8KITMalHizmet,
    required this.esikDegerMadde8Yapim,
    required this.sikayet1,
    required this.sikayet1Bedel,
    required this.sikayet2,
    required this.sikayet2Bedel,
    required this.sikayet3,
    required this.sikayet3Bedel,
    required this.sikayet4Bedel,
    required this.sonuc,
  });

  factory SinirDegerlerResponse.fromJson(Map<String, dynamic> json) =>
      _$SinirDegerlerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SinirDegerlerResponseToJson(this);
}

@JsonSerializable()
class SonucModel {
  @JsonKey(name: 'Mesaj')
  final String mesaj;

  @JsonKey(name: 'ResultCode')
  final int resultCode;

  @JsonKey(name: 'Sonuc')
  final bool sonuc;

  @JsonKey(name: 'UniqueName')
  final String? uniqueName;

  SonucModel({
    required this.mesaj,
    required this.resultCode,
    required this.sonuc,
    this.uniqueName,
  });

  factory SonucModel.fromJson(Map<String, dynamic> json) =>
      _$SonucModelFromJson(json);

  Map<String, dynamic> toJson() => _$SonucModelToJson(this);
}
