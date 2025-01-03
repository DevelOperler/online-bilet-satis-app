import 'package:flutter/material.dart';
import 'package:online_bilet_satis/services/filter_service.dart';
import 'package:online_bilet_satis/views/booking/trip_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/trip_provider.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Fetch trips when the screen is initialized
    Future.microtask(() {
      final tripProvider = Provider.of<TripProvider>(context, listen: false);
      tripProvider.fetchTrips();
    });
  }

  Future<void> _applyFilters() async {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);
    var _filterService = new FilterService();

    String startLocation = _startLocationController.text.trim();
    String endLocation = _endLocationController.text.trim();
    var tmpData =
        await _filterService.getTripsByLocation(startLocation, endLocation);

    tripProvider.setTrips(tmpData);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Sefer Listesi')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startLocationController,
                    decoration: InputDecoration(
                      labelText: 'Nereden',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _endLocationController,
                    decoration: InputDecoration(
                      labelText: 'Nereye',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _applyFilters,
            child: Text('Filtrele'),
          ),
          Expanded(
            child: Consumer<TripProvider>(
              builder: (context, tripProvider, child) {
                final trips = tripProvider.filteredTrips;
                if (trips.isEmpty) {
                  return Center(child: Text('Sefer bulunamadı.'));
                }
                return ListView.builder(
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return Card(
                      child: ListTile(
                        title:
                            Text('${trip.startLocation} → ${trip.endLocation}'),
                        subtitle:
                            Text('Firma: ${trip.name}\nFiyat: ${trip.price}'),
                        onTap: () {
                          tripProvider.selectTrip(trip);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripDetailScreen(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
