// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sinir_degerler_response.g.dart';
part 'sinir_degerler_response.freezed.dart';

@freezed
class SinirDegerlerResponse with _$SinirDegerlerResponse {
  const factory SinirDegerlerResponse({
    @JsonKey(name: 'EsikDeger_Madde13Alt') required int esikDegerMadde13Alt,
    @JsonKey(name: 'EsikDeger_Madde13Orta') required int esikDegerMadde13Orta,
    @JsonKey(name: 'EsikDeger_Madde13Ust') required int esikDegerMadde13Ust,
    @JsonKey(name: 'EsikDeger_Madde8GenelButceMalHizmet')
    required int esikDegerMadde8GenelButceMalHizmet,
    @JsonKey(name: 'EsikDeger_Madde8KITMalHizmet')
    required int esikDegerMadde8KITMalHizmet,
    @JsonKey(name: 'EsikDeger_Madde8Yapim') required int esikDegerMadde8Yapim,
    @JsonKey(name: 'Sikayet_1') required int sikayet1,
    @JsonKey(name: 'Sikayet_1_Bedel') required int sikayet1Bedel,
    @JsonKey(name: 'Sikayet_2') required int sikayet2,
    @JsonKey(name: 'Sikayet_2_Bedel') required int sikayet2Bedel,
    @JsonKey(name: 'Sikayet_3') required int sikayet3,
    @JsonKey(name: 'Sikayet_3_Bedel') required int sikayet3Bedel,
    @JsonKey(name: 'Sikayet_4_Bedel') required int sikayet4Bedel,
    @JsonKey(name: 'Sonuc') required SonucModel sonuc,
  }) = _SinirDegerlerResponse;

  factory SinirDegerlerResponse.fromJson(Map<String, dynamic> json) =>
      _$SinirDegerlerResponseFromJson(json);
}

@freezed
class SonucModel with _$SonucModel {
  const factory SonucModel({
    @JsonKey(name: 'Mesaj') required String mesaj,
    @JsonKey(name: 'ResultCode') required int resultCode,
    @JsonKey(name: 'Sonuc') required bool sonuc,
    @JsonKey(name: 'UniqueName') String? uniqueName,
  }) = _SonucModel;

  factory SonucModel.fromJson(Map<String, dynamic> json) =>
      _$SonucModelFromJson(json);
}
