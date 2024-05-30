class ServiceReportModel {
  int serviceReportId;
  DateTime date;
  String personName;
  String machineNumber;
  String machineName;
  String complaints;
  String status;

  ServiceReportModel({
    required this.serviceReportId,
    required this.date,
    required this.personName,
    required this.machineNumber,
    required this.machineName,
    required this.complaints,
    required this.status,
  });

  factory ServiceReportModel.fromJson(Map<String, dynamic> json) {
    return ServiceReportModel(
      serviceReportId: json['service_report_id'],
      date: DateTime.parse(json['date']),
      personName: json['person_name'],
      machineNumber: json['machine_number'],
      machineName: json['machine_name'],
      complaints: json['complaints'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_report_id': serviceReportId,
      'date': date.toIso8601String(),
      'person_name': personName,
      'machine_number': machineNumber,
      'machine_name': machineName,
      'complaints': complaints,
      'status': status,
    };
  }
}
