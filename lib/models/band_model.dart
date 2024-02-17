
class BandModel{
 final String? id;
 final String? name;
 final int? votes;

BandModel({
this.id,
this.name,
this.votes,
});

factory BandModel.fromJson(Map<String,dynamic> json )=> BandModel(
  id: json['id'],
  name: json['name'],
  votes: json['votes'],
);
}