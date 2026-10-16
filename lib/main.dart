import 'package:flutter/material.dart';

void main() => runApp(const DirectoryApp());

// Student data is immutable, so all fields are final.
class Student {
  final String name;
  final String course;
  final int yearLevel;
  final String email;

  const Student({
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.email,
  });

  // Customization: Provide a reusable initial for the student's avatar.
  String get fullNameInitial => name.isNotEmpty ? name[0].toUpperCase() : '?';
}

// Sample directory data is constant and does not need app state.
const List<Student> students = [
  Student(
    name: 'Kim Embarnace',
    course: 'BS Information Technology',
    yearLevel: 4,
    email: 'kim.embarnace@example.com',
  ),
  Student(
    name: 'Alexander Camacho',
    course: 'BS Computer Science',
    yearLevel: 2,
    email: 'alex.gwapo@example.com',
  ),
  Student(
    name: 'Rene Baterbonia',
    course: 'BS Information Technology',
    yearLevel: 3,
    email: 'rene.baterbonia@example.com',
  ),
  Student(
    name: 'Lexy Lore',
    course: 'BS Information Systems',
    yearLevel: 1,
    email: 'lexy.lore@example.com',
  ),
  Student(
    name: 'Ha HAHAHAHAH',
    course: 'BS Information Technology',
    yearLevel: 2,
    email: 'Ha.califa@example.com',
  ),
];

// Stateless because the heading is supplied by its parent.
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22, // Customization: Larger section heading.
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          color: color.withOpacity(0.4),
        ),
      ],
    );
  }
}

// Stateless because the icon and text come from its parent.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}

// Stateless because this card displays the Student passed to it.
class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Customization: Rounded corners.
      ),
      child: Padding(
        padding: const EdgeInsets.all(16), // Customization: Comfortable card spacing.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              foregroundColor: color,
              child: Text(
                student.fullNameInitial,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    student.course,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InfoRow(
                    icon: Icons.school,
                    text: 'Year Level: ${student.yearLevel}',
                  ),
                  const SizedBox(height: 8),
                  InfoRow(
                    icon: Icons.email_outlined,
                    text: student.email,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Stateless because the student list comes from constant sample data.
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Directory'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Students'),
          const SizedBox(height: 8),
          ...students.map(
            (student) => StudentCard(student: student),
          ),
        ],
      ),
    );
  }
}

// Stateless because this root widget configures the theme and home screen.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Directory',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const DirectoryScreen(),
    );
  }
}
