import 'package:stp/feed/page/page_item.dart';

import '../dto/response_dto.dart';

abstract class PageItemMapper {
  static const String DEFAULT_IMAGE_URL = "https://upload.wikimedia.org/wikipedia/en/thumb/8/80/Wikipedia-logo-v2.svg/330px-Wikipedia-logo-v2.svg.png";

  static PageItem fromDto(Page page) {
    // print('extract: ${page.extract ?? "null"}');
    var hasDescription = page.terms != null &&
        page.terms?.description != null &&
        page.terms!.description!.isNotEmpty;
    var description = hasDescription ? page.terms!.description![0] : "";

    var hasImage = page.original != null &&
        page.original?.source != null &&
        !page.original!.source!.endsWith('.pdf');
    var imageUrl = hasImage ? page.original!.source! : DEFAULT_IMAGE_URL;

    return PageItem(
      pageId: page.pageid ?? 0,
      imageUrl: imageUrl,
      imageWidth: page.original?.width ?? 200,
      imageHeight: page.original?.height ?? 200,
      title: page.title ?? "No title",
      description: description,
      pageUrl: page.canonicalurl ?? "https://en.wikipedia.org",
    );
  }

  static List<PageItem> fromDtoList(List<Page> pages) {
    return pages.map(fromDto).toList();
  }

  static List<PageItem> fromQueryDto(Query query) {
    if (query.pages == null) throw 'Query response does not contain pages';
    return query.pages!.map(fromDto).toList();
  }

  static List<PageItem> fromResponseModelDto(ResponseModel responseModel) {
    if (responseModel.query == null) throw 'Query response is null';
    return fromQueryDto(responseModel.query!);
  }
}
