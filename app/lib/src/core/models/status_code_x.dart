extension StatusCodeX on int {
  bool get isSuccess => this >= 200 && this <= 299;
}
