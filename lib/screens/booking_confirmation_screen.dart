import 'package:flutter/material.dart';
import '../models/space_trip.dart';
import '../utils/formatters.dart';
import '../widgets/space_ticket.dart';
import 'home_screen.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final SpaceTrip trip;
  final String passengerName;
  final String passengerEmail;
  final int passengerCount;
  final double totalPrice;
  final DateTime departureDate;

  const BookingConfirmationScreen({
    Key? key,
    required this.trip,
    required this.passengerName,
    required this.passengerEmail,
    required this.passengerCount,
    required this.totalPrice,
    required this.departureDate,
  }) : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final String _bookingReference = 'TM${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}';
  bool _showTicket = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Show ticket after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _showTicket = true;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 80,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Booking Confirmed!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your space adventure awaits',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),

                      // Space Ticket
                      if (_showTicket)
                        FadeTransition(
                          opacity: _animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.5),
                              end: Offset.zero,
                            ).animate(_animation),
                            child: SpaceTicket(
                              bookingReference: _bookingReference,
                              tripName: widget.trip.name,
                              destination: widget.trip.destination,
                              departureDate: widget.departureDate,
                              passengerName: widget.passengerName,
                              passengerCount: widget.passengerCount,
                              spacecraft: widget.trip.spacecraft,
                              duration: widget.trip.duration,
                            ),
                          ),
                        ),

                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Booking Details',
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildDetailRow(context, 'Booking Reference', _bookingReference),
                            _buildDetailRow(context, 'Trip', widget.trip.name),
                            _buildDetailRow(context, 'Destination', widget.trip.destination),
                            _buildDetailRow(context, 'Departure Date', formatDateFull(widget.departureDate)),
                            _buildDetailRow(context, 'Duration', widget.trip.duration),
                            _buildDetailRow(context, 'Passenger', widget.passengerName),
                            _buildDetailRow(context, 'Email', widget.passengerEmail),
                            _buildDetailRow(
                                context,
                                'Number of Passengers',
                                widget.passengerCount.toString()
                            ),
                            _buildDetailRow(context, 'Total Price', formatCurrency(widget.totalPrice)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.amber,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'A confirmation email has been sent to ${widget.passengerEmail} with all the details of your booking.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'What\'s Next?',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      _buildNextStepItem(
                        context,
                        '1',
                        'Medical Clearance',
                        'Complete your space travel medical assessment within 30 days of departure.',
                      ),
                      _buildNextStepItem(
                        context,
                        '2',
                        'Training Program',
                        'Attend the mandatory 3-day training program before your journey.',
                      ),
                      _buildNextStepItem(
                        context,
                        '3',
                        'Final Briefing',
                        'Join the final mission briefing 24 hours before launch.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // In a real app, this would save the ticket to the device
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ticket saved to your device'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Save Ticket'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                              (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Return to Home'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStepItem(BuildContext context, String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}