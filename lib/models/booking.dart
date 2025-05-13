import 'space_trip.dart';

enum BookingStatus {
  pending,
  confirmed,
  cancelled
}

class Passenger {
  final String name;
  final String email;
  final String passportNumber;
  final DateTime dateOfBirth;
  final String nationality;
  final String emergencyContact;

  Passenger({
    required this.name,
    required this.email,
    required this.passportNumber,
    required this.dateOfBirth,
    required this.nationality,
    required this.emergencyContact,
  });
}

class Booking {
  final String id;
  final SpaceTrip trip;
  final DateTime bookingDate;
  final List<Passenger> passengers;
  final double totalPrice;
  final BookingStatus status;
  final String paymentMethod;
  final bool insuranceIncluded;
  final String? specialRequirements;

  Booking({
    required this.id,
    required this.trip,
    required this.bookingDate,
    required this.passengers,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.insuranceIncluded,
    this.specialRequirements,
  });
}