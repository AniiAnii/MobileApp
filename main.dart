import 'package:flutter/material.dart';

void main() {
  runApp(FacultyApp());
}

class FacultyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> years = [
    'Prva godina',
    'Druga godina',
    'Treća godina',
    'Četvrta godina'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Postavljanje slike kao pozadine
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.jpg'), // Tvoja slika za pozadinu
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Fakultet na sredini ekrana
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'FAKULTET INŽENJERSKIH NAUKA', // Promeni ime fakulteta po potrebi
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50), // Prostor između naslova i godina
              Expanded(
                child: ListView.builder(
                  itemCount: years.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white70,
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(
                          years[index],
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  YearScreen(year: years[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class YearScreen extends StatelessWidget {
  final String year;

  YearScreen({required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$year'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Dodaj padding za lepši prikaz
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (year == 'Prva godina') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSemesterBox(context, 'Semestar I', 'Prva godina', [
                      'Matematika 1',
                      'Osnovi elektrotehnike',
                      'Računarski alati',
                      'Inženjerska mehanika',
                      'Engleski jezik'
                    ]),
                    _buildSemesterBox(context, 'Semestar II', 'Prva godina', [
                      'Matematika2',
                      'Pratikum iz osnova elektrotehnike',
                      'Pratikum iz osnova računarske tehnike',
                      'Osnovi računarske tehnike',
                      'Algoritmi i strukture podataka ',
                      'Osnovi preduzetničkog menadžmenta'
                    ]),
                  ],
                ),
              ],
              if (year == 'Druga godina') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSemesterBox(context, 'Semestar III', 'Druga godina', [
                      'Matematika 3',
                      'Osnovi računarske tehnike 2',
                      'Arhitektura računarskih sistema',
                      'Programski jezici'
                    ]),
                    _buildSemesterBox(context, 'Semestar IV', 'Druga godina', [
                      'Objektno orijentisano programiranje',
                      'Signali i sistemi',
                      'Elektronika',
                      'Numerička analiza i diskretna matematika',
                      'Operativni sistemi'
                    ]),
                  ],
                ),
              ],
              if (year == 'Treća godina') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSemesterBox(context, 'Semestar V', 'Treća godina', [
                      'Računarske osnovi interneta',
                      'Mikroprocesorski sistemi',
                      'Programiranje internet aplikacija'
                    ]),
                    _buildSemesterBox(context, 'Semestar VI', 'Treća godina', [
                      'Softverski inženjering',
                      'Paralelni računarski sistemi',
                      'Baze podataka'
                    ]),
                  ],
                ),
              ],
              if (year == 'Četvrta godina') ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSemesterBox(
                        context, 'Semestar VII', 'Četvrta godina', [
                      'Softverski inženjering 2',
                      'Projektovanje informacionih sistema i baza podataka'
                    ]),
                    _buildSemesterBox(
                        context, 'Semestar VIII', 'Četvrta godina', [
                      'Vestačka inteligencija',
                      'Upravljenje softverskim projektima'
                    ]),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemesterBox(BuildContext context, String semesterName,
      String year, List<String> subjects) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SemesterScreen(
              semester: semesterName,
              subjects: subjects,
            ),
          ),
        );
      },
      child: Container(
        width: 150.0, // Veličina kocke
        height: 150.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.lightBlueAccent, // Svetloplavi okvir
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(12.0), // Zaobljeni uglovi
          color: Colors.white70, // Blago providna boja kocke
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // Senka
            ),
          ],
        ),
        child: Center(
          child: Text(
            semesterName,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class SemesterScreen extends StatelessWidget {
  final String semester;
  final List<String> subjects;

  SemesterScreen({required this.semester, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(semester),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subjects[index]),
          );
        },
      ),
    );
  }
}
