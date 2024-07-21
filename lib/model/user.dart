class User
{
  String? title;
  String? subtitle;
  String? date;
  String? importance;

  userMap(){
    var mapping = {};
      mapping['title'] = title!;
      mapping['subtitle'] = subtitle!;
      mapping['date'] = date!;
      mapping['importance'] = importance!;
      return mapping;
  }
}