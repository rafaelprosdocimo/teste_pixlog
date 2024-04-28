class ResourceModel {
  final String createdAt;
  final String updatedAt;
  final String resourceId;
  final String moduleId;
  final String value;
  final String languageId;

  ResourceModel({
    required this.createdAt,
    required this.updatedAt,
    required this.resourceId,
    required this.moduleId,
    required this.value,
    required this.languageId,
  });


  Map<String, Object?> toMap() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'resourceId': resourceId,
      'moduleId': moduleId,
      'value': value,
      'languageId': languageId,
    };
  }

    @override
  String toString() {
    return 'Resource{createdAt: $createdAt, updatedAt: $updatedAt, resourceId: $resourceId, moduleId: $moduleId, value: $value, languageId: $languageId}';
  }
}


