class Resource {
  final String createdAt;
  final String updatedAt;
  final String resourceId;
  final String moduleId;
  final String value;
  final String languageId;

  Resource({
    required this.createdAt,
    required this.updatedAt,
    required this.resourceId,
    required this.moduleId,
    required this.value,
    required this.languageId,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    final resourceJson = json['resource'];

    return Resource(
      createdAt: resourceJson['created_at'].toString(), // Store as string
      updatedAt: resourceJson['updated_at'].toString(), // Store as string
      resourceId: resourceJson['resource_id'].toString(),
      moduleId: resourceJson['module_id'].toString(),
      value: resourceJson['value'].toString(),
      languageId: resourceJson['language_id'].toString(),
    );
  }
}