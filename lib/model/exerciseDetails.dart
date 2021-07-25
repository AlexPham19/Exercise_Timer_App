class ExerciseDetails{
  final String name;
  final String help;
  final String imgUrl;
  final int id;

  ExerciseDetails(this.name, this.help, this.imgUrl, this.id);

  factory ExerciseDetails.fromMap(Map<String, dynamic> json){
    return ExerciseDetails(
      json['name'] as String,
      json['description'] as String,
      json['image'] as String,
      json['id'] as int,
    );
  }
}