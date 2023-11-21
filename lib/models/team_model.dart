class Team {
  final int id;
  final String name;
  final String abbreviation;
  final int yearFounded;
  final bool hasPreviousName;

  const Team({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.yearFounded,
    required this.hasPreviousName,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String,
      yearFounded: json['year_founded'] as int,
      hasPreviousName: json['has_previous_name'] as bool,
    );
  }
}
