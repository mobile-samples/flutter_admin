class UserFilter {
  UserFilter(
    this.username,
    this.displayName,
    this.status,
    this.limit,
    this.page,
  );
  String username;
  String displayName;
  List<String> status;
  int limit;
  int page;
}
