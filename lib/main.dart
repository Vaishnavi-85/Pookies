import 'package:flutter/material.dart';

void main() {
  runApp(TripPlannerApp());
}

class TripPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Planner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TripPlannerHomePage(),
    );
  }
}

class TripPlannerHomePage extends StatefulWidget {
  @override
  _TripPlannerHomePageState createState() => _TripPlannerHomePageState();
}

class _TripPlannerHomePageState extends State<TripPlannerHomePage> {
  final List<Map<String, String>> _trips = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void _addTrip() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _trips.add({
          'destination': _destinationController.text,
          'date': _dateController.text,
        });
      });
      _destinationController.clear();
      _dateController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showAddTripDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Trip'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Destination'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a destination';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date (e.g., 2025-01-30)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addTrip,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Planner'),
      ),
      body: _trips.isEmpty
          ? Center(
              child: Text(
                'No trips added yet. Start planning!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _trips.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(_trips[index]['destination']!),
                    subtitle: Text('Date: ${_trips[index]['date']}'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTripDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
