import 'package:json_annotation/json_annotation.dart';

part 'response_dto.g.dart';

@JsonSerializable()
class ResponseModel {
  // final bool? batchcomplete;
  // final Continue? continue_;
  // final Warnings? warnings;
  final Query? query;

  // ResponseModel({this.batchcomplete, this.continue_, this.warnings, this.query});

  ResponseModel({this.query});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  @override
  String toString() {
    return 'ResponseModel{'
        // 'batchcomplete: $batchcomplete,'
        // ' continue_: $continue_,'
        // ' warnings: $warnings,'
        ' query: $query'
        '}';
  }
}

// @JsonSerializable()
// class Continue {
//   final String? grncontinue;
//   final String? continue_;
//
//   Continue({this.grncontinue, this.continue_});
//
//   factory Continue.fromJson(Map<String, dynamic> json) =>
//       _$ContinueFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ContinueToJson(this);
//
//   @override
//   String toString() {
//     return 'Continue{grncontinue: $grncontinue, continue_: $continue_}';
//   }
// }

// @JsonSerializable()
// class Warnings {
//   final Extracts? extracts;
//
//   Warnings({this.extracts});
//
//   factory Warnings.fromJson(Map<String, dynamic> json) =>
//       _$WarningsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$WarningsToJson(this);
//
//   @override
//   String toString() {
//     return 'Warnings{extracts: $extracts}';
//   }
// }

// @JsonSerializable()
// class Extracts {
//   final String? warnings;
//
//   Extracts({this.warnings});
//
//   factory Extracts.fromJson(Map<String, dynamic> json) =>
//       _$ExtractsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ExtractsToJson(this);
//
//   @override
//   String toString() {
//     return 'Extracts{warnings: $warnings}';
//   }
// }

@JsonSerializable()
class Query {
  final List<Page>? pages;

  Query({this.pages});

  factory Query.fromJson(Map<String, dynamic> json) => _$QueryFromJson(json);

  Map<String, dynamic> toJson() => _$QueryToJson(this);

  @override
  String toString() {
    return 'Query{pages: $pages}';
  }
}

@JsonSerializable()
class Page {
  final int? pageid;

  // final int? ns;
  final String? title;
  final String? extract;
  final Terms? terms;

  // final Thumbnail? thumbnail;
  // final String? pageimage;
  final Original? original;
  final String? canonicalurl;

  Page(
      {this.pageid,
      // this.ns,
      this.title,
      this.extract,
      this.terms,
      // this.thumbnail,
      // this.pageimage,
      this.original,
      this.canonicalurl});

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  String toString() {
    return 'Page{'
        'pageid: $pageid, '
        // 'ns: $ns, '
        'title: $title, '
        // 'extract: $extract, '
        'terms: $terms, '
        // 'thumbnail: $thumbnail, '
        // 'pageimage: $pageimage,'
        'original: $original, '
        'canonicalurl: $canonicalurl}';
  }
}

@JsonSerializable()
class Terms {
  final List<String>? alias;
  final List<String>? label;
  final List<String>? description;

  Terms({this.alias, this.label, this.description});

  factory Terms.fromJson(Map<String, dynamic> json) => _$TermsFromJson(json);

  Map<String, dynamic> toJson() => _$TermsToJson(this);

  @override
  String toString() {
    return 'Terms{alias: $alias, label: $label, description: $description}';
  }
}

// @JsonSerializable()
// class Thumbnail {
//   final String? source;
//   final int? width;
//   final int? height;
//
//   Thumbnail({this.source, this.width, this.height});
//
//   factory Thumbnail.fromJson(Map<String, dynamic> json) =>
//       _$ThumbnailFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
//
//   @override
//   String toString() {
//     return 'Thumbnail{source: $source, width: $width, height: $height}';
//   }
// }

@JsonSerializable()
class Original {
  final String? source;
  final int? width;
  final int? height;

  Original({this.source, this.width, this.height});

  factory Original.fromJson(Map<String, dynamic> json) =>
      _$OriginalFromJson(json);

  Map<String, dynamic> toJson() => _$OriginalToJson(this);

  @override
  String toString() {
    return 'Original{source: $source, width: $width, height: $height}';
  }
}
