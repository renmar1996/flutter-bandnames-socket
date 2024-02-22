
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
  id: json.containsKey('id')? json['id']: '',
  name: json.containsKey('name')? json['name']: '',
  votes: json.containsKey('votes')? json['votes']: '',
);

Map<String,dynamic> toJson(){
  return {
    'id':id,
    'name':name,
    'votes':votes,
    };
}
}