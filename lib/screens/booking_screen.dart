import 'package:flutter/material.dart';
import '../models/space_trip.dart';
import '../utils/formatters.dart';
import 'booking_confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final SpaceTrip trip;

  const BookingScreen({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passportController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  String _nationality = 'United States';
  DateTime _dateOfBirth = DateTime(1990, 1, 1);
  bool _insuranceIncluded = false;
  int _passengerCount = 1;
  String _paymentMethod = 'Credit Card';

  final List<String> _nationalities = [
    'Omani',
    'Egyptian',
    'Indian',
    'Pakistani',
    'Bangladeshi',
    'Filipino',
    'Syrian',
    'Sudanese',
    'Yemeni',
    'Jordanian',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'Brazil',
  ];

  final List<String> _paymentMethods = [
    'Credit Card',
    'Debit Card',
    'Mobile Payment (Omantel)',
    'PayPal',
    'Apple Pay',
    'Google Pay',
    'Crypto Currency',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passportController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.trip.price * _passengerCount;
    final insuranceCost = totalPrice * 0.05; // 5% of total price
    final finalPrice = _insuranceIncluded ? totalPrice + insuranceCost : totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Trip'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Trip Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.trip.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Destination: ${widget.trip.destination}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Departure: ${formatDateFull(widget.trip.departureDate)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Duration: ${widget.trip.duration}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price per person:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          formatCurrency(widget.trip.price),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Passenger Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passportController,
                      decoration: const InputDecoration(
                        labelText: 'Passport Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your passport number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Nationality',
                        border: OutlineInputBorder(),
                      ),
                      value: _nationality,
                      items: _nationalities.map((String nationality) {
                        return DropdownMenuItem<String>(
                          value: nationality,
                          child: Text(nationality),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _nationality = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: _showDatePicker,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatDateFull(_dateOfBirth)),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emergencyContactController,
                      decoration: const InputDecoration(
                        labelText: 'Emergency Contact',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an emergency contact';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Booking Options',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Number of Passengers:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _passengerCount > 1
                              ? () {
                            setState(() {
                              _passengerCount--;
                            });
                          }
                              : null,
                        ),
                        Text(
                          _passengerCount.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _passengerCount < widget.trip.availableSeats
                              ? () {
                            setState(() {
                              _passengerCount++;
                            });
                          }
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Payment Method',
                        border: OutlineInputBorder(),
                      ),
                      value: _paymentMethod,
                      items: _paymentMethods.map((String method) {
                        return DropdownMenuItem<String>(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _paymentMethod = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(
                        'Space Travel Insurance',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text(
                        'Adds 5% to your total cost (${formatCurrency(insuranceCost)})',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      value: _insuranceIncluded,
                      onChanged: (bool value) {
                        setState(() {
                          _insuranceIncluded = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trip Cost:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          formatCurrency(widget.trip.price * _passengerCount),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    if (_insuranceIncluded) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Insurance:',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            formatCurrency(insuranceCost),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formatCurrency(finalPrice),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingConfirmationScreen(
                          trip: widget.trip,
                          passengerName: _nameController.text,
                          passengerEmail: _emailController.text,
                          passengerCount: _passengerCount,
                          totalPrice: finalPrice,
                          departureDate: widget.trip.departureDate,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}