// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      query: json['query'] == null
          ? null
          : Query.fromJson(json['query'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'query': instance.query,
    };

Query _$QueryFromJson(Map<String, dynamic> json) => Query(
      pages: (json['pages'] as List<dynamic>?)
          ?.map((e) => Page.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QueryToJson(Query instance) => <String, dynamic>{
      'pages': instance.pages,
    };

Page _$PageFromJson(Map<String, dynamic> json) => Page(
      pageid: json['pageid'] as int?,
      title: json['title'] as String?,
      extract: json['extract'] as String?,
      terms: json['terms'] == null
          ? null
          : Terms.fromJson(json['terms'] as Map<String, dynamic>),
      original: json['original'] == null
          ? null
          : Original.fromJson(json['original'] as Map<String, dynamic>),
      canonicalurl: json['canonicalurl'] as String?,
    );

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'pageid': instance.pageid,
      'title': instance.title,
      'extract': instance.extract,
      'terms': instance.terms,
      'original': instance.original,
      'canonicalurl': instance.canonicalurl,
    };

Terms _$TermsFromJson(Map<String, dynamic> json) => Terms(
      alias:
          (json['alias'] as List<dynamic>?)?.map((e) => e as String).toList(),
      label:
          (json['label'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: (json['description'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TermsToJson(Terms instance) => <String, dynamic>{
      'alias': instance.alias,
      'label': instance.label,
      'description': instance.description,
    };

Original _$OriginalFromJson(Map<String, dynamic> json) => Original(
      source: json['source'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$OriginalToJson(Original instance) => <String, dynamic>{
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
    };
