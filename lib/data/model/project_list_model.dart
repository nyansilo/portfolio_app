class ProjectList {


  int id;
  String name;
  String technology;
  String description;
  String price;
  String image;
  String url;
  String created;
  String slug;
  int owner;
  int category;

  ProjectList(
      {this.id,
        this.name,
        this.technology,
        this.description,
        this.price,
        this.image,
        this.url,
        this.created,
        this.slug,
        this.owner,
        this.category});

  ProjectList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    technology = json['technology'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    url = json['url'];
    created = json['created'];
    slug = json['slug'];
    owner = json['owner'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['technology'] = this.technology;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    data['url'] = this.url;
    data['created'] = this.created;
    data['slug'] = this.slug;
    data['owner'] = this.owner;
    data['category'] = this.category;
    return data;
  }
}