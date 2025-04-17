class Transport {
  final int id;
  final String routeName;
  final String startLocation;
  final String endLocation;
  final String departureTime;
  final String arrivalTime;
  final String vehicleType;
  final String driverName;
  final String driverNumber;
  final int departmentId;

  Transport({
    required this.id,
    required this.routeName,
    required this.startLocation,
    required this.endLocation,
    required this.departureTime,
    required this.arrivalTime,
    required this.vehicleType,
    required this.driverName,
    required this.driverNumber,
    required this.departmentId,
  });

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      id: json['id'],
      routeName: json['route_name'],
      startLocation: json['start_location'],
      endLocation: json['end_location'],
      departureTime: json['departure_time'],
      arrivalTime: json['arrival_time'],
      vehicleType: json['vehicle_type'],
      driverName: json['driver_name']??'',
      driverNumber: json['driver_number']??'',
      departmentId: json['department_id'],
    );
  }
}
