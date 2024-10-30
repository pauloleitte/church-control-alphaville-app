class PaginationModel {
  int? total;
  int? totalPage;
  int? page;
  int? totalPages;

  PaginationModel({this.total, this.totalPage, this.page, this.totalPages});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['totalPage'];
    page = json['page'];
    totalPages = json['totalPages'];
  }
}
