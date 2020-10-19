class Report {
  final int id;
  final String title;
  final String username_emp;
  final String imageUrl;
  final String username_tech;
  final String address;
  final String description;
  final int status;
  final String create;
  final String solve;
  final String solution;
  final String completed;

  Report({
    this.address,
    this.description,
    this.username_emp,
    this.username_tech,
    this.completed,
    this.create,
    this.solve,
    this.status,
    this.id,
    this.title,
    this.imageUrl,
    this.solution,
  });
  factory Report.fromJson(Map<String, dynamic> jsonData) {
    return Report(
      id: jsonData['id'],
      title: jsonData['title'],
      username_emp: jsonData['username_emp'],
      username_tech: jsonData['username_tech'],
      address: jsonData['address'],
      solution: jsonData['solution'],
      description: jsonData['description'],
      status: jsonData['status'],
      create: jsonData['createreport'].toString(),
      solve: jsonData['solve'],
      completed: jsonData['completed'],
      imageUrl: "http://helpdesksolutionszz.000webhostapp.com/File/File_img/" +
          jsonData['image'],
    );
  }
}

class NotificationRB {
  final int id;
  final String username;
  final int post_id;
  final int status;
  final int checkey;
  NotificationRB(
      {this.id, this.username, this.post_id, this.status, this.checkey});
  factory NotificationRB.fromJson(Map<String, dynamic> jsonData) {
    return NotificationRB(
      id: jsonData['id'],
      username: jsonData['username'],
      post_id: jsonData['post_id'],
      status: jsonData['status'],
      checkey: jsonData['checkkey'],
    );
  }
}

class Messages {
  final int id;
  final String containts;
  final int user_type;
  final String date;
  final String username;
  Messages({this.id, this.containts, this.user_type, this.date, this.username});
  factory Messages.fromJson(Map<String, dynamic> jsonData) {
    return Messages(
      id: jsonData['id'],
      containts: jsonData['contains'],
      user_type: jsonData['user_type'],
      date: jsonData['time'].toString(),
      username: jsonData['username_emp'],
    );
  }
}
