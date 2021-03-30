class Imd {
  final String area;
  final String group;
  final String equipment;
  final String activity;
  final String optional;
  final DateTime osdate;
  final String url;
  final String uemail;
  final String docId;
  final String date;
  final String privacy;
  Imd(
      {this.area,
      this.group,
      this.equipment,
      this.activity,
      this.optional,
      this.osdate,
      this.url,
      this.uemail,
      this.docId,
      this.date,
      this.privacy});

  Map<String, dynamic> toMap() {
    return {
      'uemail': uemail,
      'area': area,
      'group': group,
      'equipment': equipment,
      'activity': activity,
      'optional': optional,
      'docId': docId,
      'date': date
    };
  }
}
