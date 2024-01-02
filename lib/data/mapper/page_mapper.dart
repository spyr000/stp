import 'package:stp/feed/page/page_item.dart';

import '../dto/response_dto.dart';

abstract class PageMapper {
  static PageItem fromDto(Page page) {
    var description;
    if (page.terms != null &&
        page.terms?.description != null &&
        page.terms!.description!.isNotEmpty) {
      description = page.terms!.description![0];
    } else {
      description = "";
    }
    var imageUrl;
    if (page.original != null && page.original?.source != null) //&& page.original!.source!.endsWith('.svg'))
    {
      if (page.original!.source!.endsWith('.svg')) {
        print("svg: ${page.original!.source}");
      }
      imageUrl = page.original!.source;
    } else {
      imageUrl = "https://en.wikipedia.org/static/images/icons/wikipedia.png";
    }

    // var description = page.terms!.description![0];
    return PageItem(
      imageUrl: imageUrl,
      title: page.title ?? "null",
      description: description,
      pageUrl: page.canonicalurl ?? "null",
    );
  }

  static List<PageItem> fromDtoList(List<Page> pages) {
    return pages.map(fromDto).toList();
  }

  static List<PageItem> fromQueryDto(Query query) {
    if (query.pages == null) print("pages is null");
    return query.pages!.map(fromDto).toList();
    List<PageItem>;
  }

  static List<PageItem> fromResponseModelDto(ResponseModel responseModel) {
    if (responseModel.query == null) print("query is null");
    return fromQueryDto(responseModel.query!);
  }
}
