class Task
{
  String? title;
  String? subtitle;
  String? date;
  String? importance;

  TaskMap(){
    var mapping = <String, dynamic>{};
      mapping['title'] = title!;
      mapping['subtitle'] = subtitle!;
      mapping['date'] = date!;
      mapping['importance'] = importance!;
      return mapping;
  }
}