import 'package:flutter/material.dart';

class SportsPage extends StatefulWidget {
  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  final SportsManager _sportsManager = SportsManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sports Management'),
      ),
      body: ListView(
        children: _sportsManager.sports.map((sport) {
          return ListTile(
            title: Text(sport.name),
            subtitle: Text('Rate: ${sport.rate}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to a new screen to edit the sport rate
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Call the removeSport method on the SportsManager
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a new screen to add a new sport
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

///////
///
class Sport {
  final String name;
  double rate;

  Sport({required this.name, required this.rate});

  void editRate(double newRate) {
    rate = newRate;
  }

  void remove() {
    // Code to remove the sport from the list
  }
}

class SportsManager {
  final List<Sport> _sports = [];

  void addSport(Sport sport) {
    _sports.add(sport);
  }

  void removeSport(Sport sport) {
    sport.remove();
  }

  void editSportRate(String name, double newRate) {
    final sport = _sports.firstWhere((element) => element.name == name);
    sport.editRate(newRate);
  }

  List<Sport> get sports => _sports;
}
