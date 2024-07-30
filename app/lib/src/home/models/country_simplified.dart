class CountrySimplified {
  final String code;
  final String officialName;
  final String commonName;
  final String flag;

  const CountrySimplified({
    required this.code,
    required this.officialName,
    required this.commonName,
    required this.flag,
  });

  factory CountrySimplified.fromJson(Map<String, dynamic> json) {
    final nameNode = json['name'];

    return CountrySimplified(
      code: json['cca3'],
      officialName: nameNode['official'],
      commonName: nameNode['common'],
      flag: json['flags']?['png'],
    );
  }
}
