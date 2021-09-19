class UserFilter {
  UserFilter(
      {required this.username,
      required this.displayName,
      required this.status,
      required this.limit,
      required this.page});
  String username;
  String displayName;
  List<String> status;
  int limit;
  int page;
}
