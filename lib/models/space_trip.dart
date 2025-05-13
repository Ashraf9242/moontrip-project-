class SpaceTrip {
  final String id;
  final String name;
  final String destination;
  final String description;
  final double price;
  final String duration;
  final String distance;
  final String imageUrl;
  final List<String> highlights;
  final DateTime departureDate;
  final int availableSeats;
  final String spacecraft;
  final double rating;

  SpaceTrip({
    required this.id,
    required this.name,
    required this.destination,
    required this.description,
    required this.price,
    required this.duration,
    required this.distance,
    required this.imageUrl,
    required this.highlights,
    required this.departureDate,
    required this.availableSeats,
    required this.spacecraft,
    required this.rating,
  });
}

// Sample data
List<SpaceTrip> sampleTrips = [
  SpaceTrip(
    id: '1',
    name: 'Lunar Odyssey',
    destination: 'Moon',
    description: 'Experience the thrill of walking on the lunar surface and witness Earth from a perspective few have seen. Our Lunar Odyssey trip takes you to the most iconic locations on the Moon, including the Sea of Tranquility where humans first stepped on another world.',
    price: 28500000,
    duration: '8 days',
    distance: '384,400 km',
    imageUrl: 'assets/images/moon.jpeg',
    highlights: [
      'Moonwalk experience',
      'Earth observation deck',
      'Lunar rover expedition',
      'Visit to Apollo landing sites',
    ],
    departureDate: DateTime(2025, 7, 20),
    availableSeats: 6,
    spacecraft: 'Artemis Cruiser',
    rating: 4.9,
  ),
  SpaceTrip(
    id: '2',
    name: 'Mars Red Planet Explorer',
    destination: 'Mars',
    description: 'Be among the first humans to set foot on the Red Planet. Explore Martian landscapes, study the planet\'s geology, and help establish the foundations for future human settlements on Mars.',
    price: 75000000,
    duration: '1 year',
    distance: '54.6 million km',
    imageUrl: 'assets/images/mars.jpeg',
    highlights: [
      'Mars surface expedition',
      'Olympus Mons climb',
      'Valles Marineris canyon trek',
      'Scientific research participation',
    ],
    departureDate: DateTime(2026, 11, 15),
    availableSeats: 4,
    spacecraft: 'Ares Pioneer',
    rating: 4.7,
  ),
  SpaceTrip(
    id: '3',
    name: 'Orbital Experience',
    destination: 'Earth Orbit',
    description: 'Circle the Earth in our state-of-the-art space station. Experience weightlessness and witness breathtaking views of our home planet from low Earth orbit.',
    price: 12000000,
    duration: '10 days',
    distance: '400 km altitude',
    imageUrl: 'assets/images/EarthOrbit.jpeg',
    highlights: [
      'Zero gravity experience',
      'Earth observation',
      'Space station tour',
      'Spacewalk opportunity',
    ],
    departureDate: DateTime(2025, 3, 10),
    availableSeats: 8,
    spacecraft: 'Celestial Station',
    rating: 4.8,
  ),
  SpaceTrip(
    id: '4',
    name: 'Venus Flyby',
    destination: 'Venus',
    description: 'Journey to our nearest planetary neighbor for a close flyby mission. Study the dense atmosphere and unique climate of Venus from the safety of our specially designed spacecraft.',
    price: 45000000,
    duration: '3 months',
    distance: '41 million km',
    imageUrl: 'assets/images/venus.jpeg',
    highlights: [
      'Venus cloud observation',
      'Atmospheric research',
      'Solar corona studies',
      'Interplanetary navigation training',
    ],
    departureDate: DateTime(2026, 5, 8),
    availableSeats: 5,
    spacecraft: 'Morning Star',
    rating: 4.5,
  ),
];