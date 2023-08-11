import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        hintColor: Colors.blueAccent,
      ),
      home: const UserDashboard(),
    );
  }
}

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  UserDashboardState createState() => UserDashboardState();
}

class UserDashboardState extends State<UserDashboard> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _phoneNumber = '';
  String _role = '';
  String _companyName = '';

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return _buildForm();
          } else {
            // Tablet or desktop layout
            return Center(
              child: SizedBox(
                width: 600,
                child: _buildForm(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildField('Name', _name, (value) => _name = value!),
                  const SizedBox(height: 20), // Added space
                  _buildField('Email', _email, (value) => _email = value!),
                  const SizedBox(height: 20), // Added space
                  _buildField('Phone Number', _phoneNumber,
                      (value) => _phoneNumber = value!),
                  const SizedBox(height: 20), // Added space
                  _buildField('Role', _role, (value) => _role = value!),
                  const SizedBox(height: 20), // Added space
                  _buildField('Company Name', _companyName,
                      (value) => _companyName = value!),
                ],
              ),
            ),
            const SizedBox(height: 20), // Added space above the buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        _isEditing = false;
                      });
                    }
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(_isEditing ? 'Cancel' : 'Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      String label, String initialValue, Function(String?) onSave) {
    return _isEditing
        ? TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: label,
              filled: true,
              fillColor: Colors.grey[100],
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $label';
              }
              return null;
            },
            onSaved: onSave,
          )
        : ListTile(
            title: Text(label, style: TextStyle(color: Colors.teal[700])),
            subtitle: Text(initialValue),
          );
  }
}
