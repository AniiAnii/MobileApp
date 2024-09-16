import 'package:flutter/material.dart';

class SubjectScreen extends StatefulWidget {
  final String subjectName;

  SubjectScreen({required this.subjectName});

  @override
  _SubjectScreenState createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Map<String, dynamic>> assignments = []; // Lista za čuvanje obaveza

  final TextEditingController _assignmentController = TextEditingController();
  final TextEditingController _maxPointsController = TextEditingController();
  final TextEditingController _earnedPointsController = TextEditingController();

  void _addAssignment() {
    String assignmentName = _assignmentController.text;
    int maxPoints = int.tryParse(_maxPointsController.text) ?? 0;
    int earnedPoints = int.tryParse(_earnedPointsController.text) ?? 0;

    setState(() {
      assignments.add({
        'name': assignmentName,
        'maxPoints': maxPoints,
        'earnedPoints': earnedPoints,
      });
    });

    // Očisti polja nakon unosa
    _assignmentController.clear();
    _maxPointsController.clear();
    _earnedPointsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Unos obaveza
            TextField(
              controller: _assignmentController,
              decoration: InputDecoration(
                labelText: 'Naziv obaveze',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _maxPointsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Maksimalan broj poena',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _earnedPointsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Osvojeni broj poena',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAssignment,
              child: Text('Dodaj obavezu'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Prikaz obaveza
            Expanded(
              child: ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (context, index) {
                  final assignment = assignments[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.lightBlue, width: 2),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assignment['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.assignment, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
                                    'Osvojeni poeni:',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Text(
                                '${assignment['earnedPoints']} / ${assignment['maxPoints']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
