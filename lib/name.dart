class User {

final String id; 

final String name;

final String position;


const User({

required this.id,

required this.name,

required this.position,

});

static User fromJson(json)=> User(

id: json['id'],

name: json['name'],

position: json['position'],
);

}