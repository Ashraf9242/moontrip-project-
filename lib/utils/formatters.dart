import 'package:intl/intl.dart';

/// Formats a numeric value as currency with dollar sign
///
/// Example: formatCurrency(1250000) returns "$1,250,000.00"
String formatCurrency(double amount) {
  try {
    final formatter = NumberFormat.currency(
      symbol: 'OMR',
      decimalDigits: 3,
      locale: 'en_OM',
    );
    return formatter.format(amount);
  } catch (e) {
    // Fallback formatting if there's an error
    return 'OMR -${amount.toStringAsFixed(3)}';
  }
}

/// Formats a DateTime object to a short date format
///
/// Example: formatDate(DateTime(2025, 7, 20)) returns "Jul 20, 2025"
String formatDate(DateTime date) {
  try {
    return DateFormat('MMM d, yyyy').format(date);
  } catch (e) {
    // Fallback formatting if there's an error
    return '${date.month}/${date.day}/${date.year}';
  }
}

/// Formats a DateTime object to a full date format with day of week
///
/// Example: formatDateFull(DateTime(2025, 7, 20)) returns "Sunday, July 20, 2025"
String formatDateFull(DateTime date) {
  try {
    return DateFormat('EEEE, MMMM d, yyyy').format(date);
  } catch (e) {
    // Fallback formatting if there's an error
    return '${date.month}/${date.day}/${date.year}';
  }
}

/// Formats a DateTime object to show date and time
///
/// Example: formatDateTime(DateTime(2025, 7, 20, 9, 30)) returns "Jul 20, 2025 at 9:30 AM"
String formatDateTime(DateTime dateTime) {
  try {
    return DateFormat('MMM d, yyyy \'at\' h:mm a').format(dateTime);
  } catch (e) {
    // Fallback formatting if there's an error
    return '${dateTime.month}/${dateTime.day}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}

/// Formats a large number with commas for better readability
///
/// Example: formatNumber(1250000) returns "1,250,000"
String formatNumber(num number) {
  try {
    return NumberFormat('#,###').format(number);
  } catch (e) {
    // Fallback formatting if there's an error
    return number.toString();
  }
}

/// Formats a distance in kilometers with appropriate units
///
/// Example: formatDistance(384400) returns "384,400 km"
String formatDistance(num kilometers) {
  try {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(kilometers)} km';
  } catch (e) {
    // Fallback formatting if there's an error
    return '$kilometers km';
  }
}

/// Formats a duration string to be more readable
///
/// Example: formatDuration("8 days") returns "8 days"
/// This can be expanded to handle more complex duration formatting
String formatDuration(String duration) {
  return duration;
}

/// Formats a booking reference to be more readable with spaces
///
/// Example: formatBookingReference("TM12345678") returns "TM 1234 5678"
String formatBookingReference(String reference) {
  if (reference.length >= 10 && reference.startsWith('TM')) {
    return '${reference.substring(0, 2)} ${reference.substring(2, 6)} ${reference.substring(6)}';
  }
  return reference;
}