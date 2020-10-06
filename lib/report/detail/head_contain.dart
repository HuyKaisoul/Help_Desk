class Report {
  final String id;
  final String title;
  final String username_emp;
  final String imageUrl;
  final String username_tech;
  final String address;
  final String description;
  final String status;
  final String create;
  final String solve;
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
  });
  factory Report.fromJson(Map<String, dynamic> jsonData) {
    return Report(
      id: jsonData['id'],
      title: jsonData['title'],
      username_emp: jsonData['name_emp'],
      username_tech: jsonData['name_tech'],
      address: jsonData['address'],
      description: jsonData['description'],
      status: jsonData['status'],
      create: jsonData['create'],
      solve: jsonData['solve'],
      completed: jsonData['completed'],
      imageUrl: "http://helpdesksolutionszz.000webhostapp.com/ConnectPHP/img/" +
          jsonData['image_url'],
    );
  }
}
