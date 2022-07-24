class PagingResponse<T> {
  final int? nextPage;
  final int? page;
  final int? perPage;
  final int? prevPage;
  final int? total;
  final int? totalPages;
  final List<T>? data;

  PagingResponse({
    this.nextPage,
    this.page,
    this.perPage,
    this.prevPage,
    this.total,
    this.totalPages,
    this.data,
  });
}
