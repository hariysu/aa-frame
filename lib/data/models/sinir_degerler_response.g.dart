// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sinir_degerler_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SinirDegerlerResponseImpl _$$SinirDegerlerResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SinirDegerlerResponseImpl(
      esikDegerMadde13Alt: (json['EsikDeger_Madde13Alt'] as num).toInt(),
      esikDegerMadde13Orta: (json['EsikDeger_Madde13Orta'] as num).toInt(),
      esikDegerMadde13Ust: (json['EsikDeger_Madde13Ust'] as num).toInt(),
      esikDegerMadde8GenelButceMalHizmet:
          (json['EsikDeger_Madde8GenelButceMalHizmet'] as num).toInt(),
      esikDegerMadde8KITMalHizmet:
          (json['EsikDeger_Madde8KITMalHizmet'] as num).toInt(),
      esikDegerMadde8Yapim: (json['EsikDeger_Madde8Yapim'] as num).toInt(),
      sikayet1: (json['Sikayet_1'] as num).toInt(),
      sikayet1Bedel: (json['Sikayet_1_Bedel'] as num).toInt(),
      sikayet2: (json['Sikayet_2'] as num).toInt(),
      sikayet2Bedel: (json['Sikayet_2_Bedel'] as num).toInt(),
      sikayet3: (json['Sikayet_3'] as num).toInt(),
      sikayet3Bedel: (json['Sikayet_3_Bedel'] as num).toInt(),
      sikayet4Bedel: (json['Sikayet_4_Bedel'] as num).toInt(),
      sonuc: SonucModel.fromJson(json['Sonuc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SinirDegerlerResponseImplToJson(
        _$SinirDegerlerResponseImpl instance) =>
    <String, dynamic>{
      'EsikDeger_Madde13Alt': instance.esikDegerMadde13Alt,
      'EsikDeger_Madde13Orta': instance.esikDegerMadde13Orta,
      'EsikDeger_Madde13Ust': instance.esikDegerMadde13Ust,
      'EsikDeger_Madde8GenelButceMalHizmet':
          instance.esikDegerMadde8GenelButceMalHizmet,
      'EsikDeger_Madde8KITMalHizmet': instance.esikDegerMadde8KITMalHizmet,
      'EsikDeger_Madde8Yapim': instance.esikDegerMadde8Yapim,
      'Sikayet_1': instance.sikayet1,
      'Sikayet_1_Bedel': instance.sikayet1Bedel,
      'Sikayet_2': instance.sikayet2,
      'Sikayet_2_Bedel': instance.sikayet2Bedel,
      'Sikayet_3': instance.sikayet3,
      'Sikayet_3_Bedel': instance.sikayet3Bedel,
      'Sikayet_4_Bedel': instance.sikayet4Bedel,
      'Sonuc': instance.sonuc,
    };

_$SonucModelImpl _$$SonucModelImplFromJson(Map<String, dynamic> json) =>
    _$SonucModelImpl(
      mesaj: json['Mesaj'] as String,
      resultCode: (json['ResultCode'] as num).toInt(),
      sonuc: json['Sonuc'] as bool,
      uniqueName: json['UniqueName'] as String?,
    );

Map<String, dynamic> _$$SonucModelImplToJson(_$SonucModelImpl instance) =>
    <String, dynamic>{
      'Mesaj': instance.mesaj,
      'ResultCode': instance.resultCode,
      'Sonuc': instance.sonuc,
      'UniqueName': instance.uniqueName,
    };
