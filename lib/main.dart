import 'package:flutter/material.dart';

// Student model: stores each student's information.
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

  // Customization: Generates initials for the student's avatar.
  String get fullNameInitial {
    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }

    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

// Reusable heading widget.
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),

        // Customization: Adds a subtitle under the section heading.
        const Text(
          'Browse the students and their information below.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        const Divider(),
      ],
    );
  }
}

// Reusable row for displaying student details.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

// Reusable card for each student.
class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Customization: Adds a subtle shadow to each student card.
      elevation: 3,

      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 2,
      ),

      // Customization: Uses rounded corners for a modern card design.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        // Customization: Adds comfortable spacing inside the card.
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                student.fullNameInitial,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InfoRow(
                    icon: Icons.school_outlined,
                    label: 'Course',
                    value: student.course,
                  ),
                  InfoRow(
                    icon: Icons.calendar_month_outlined,
                    label: 'Year Level',
                    value: '${student.yearLevel}',
                  ),
                  InfoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: student.email,
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

// Main screen displaying the student directory.
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  static const List<Student> students = [
    Student(
      name: 'Kim Embarnace',
      course: 'BS Information Technology',
      yearLevel: 1,
      email: 'kim@example.com',
    ),
    Student(
      name: 'Alexander Camacho',
      course: 'BS Computer Science',
      yearLevel: 2,
      email: 'alexander@example.com',
    ),
    Student(
      name: 'Rene Baterbonia',
      course: 'BS Information Technology',
      yearLevel: 3,
      email: 'rene@example.com',
    ),
    Student(
      name: 'Lexy Lore',
      course: 'BS Information Systems',
      yearLevel: 2,
      email: 'lexy@example.com',
    ),
    Student(
      name: 'Ha HAHAHAHAH',
      course: 'BS Computer Science',
      yearLevel: 1,
      email: 'student5@example.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Directory',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SectionHeader(title: 'Our Students'),
              const SizedBox(height: 8),
              ...students.map(
                (student) => StudentCard(student: student),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Root application widget.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Directory',
      debugShowCheckedModeBanner: false,

      // Customization: Applies a consistent Material 3 indigo theme.
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),

      home: const DirectoryScreen(),
    );
  }
}

void main() {
  runApp(const DirectoryApp());
}
