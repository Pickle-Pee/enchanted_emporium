import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enchanted_emporium/widgets/main_layout.dart'; // Импорт main_layout

class ProfileScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  ProfileScreen({required this.cart});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;
  String? name;
  bool _isEditing = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  List<Map<String, dynamic>> purchaseHistory = [
    {'date': '2023-01-01', 'product': 'Product 1', 'price': 29.99},
    {'date': '2023-02-15', 'product': 'Product 2', 'price': 39.99},
    {'date': '2023-03-30', 'product': 'Product 3', 'price': 49.99},
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      name = prefs.getString('name') ?? '';
      _emailController.text = email!;
      _nameController.text = name!;
    });
  }

  void _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('name', _nameController.text);
    setState(() {
      email = _emailController.text;
      name = _nameController.text;
      _isEditing = false;
    });
  }

  void _changePassword() {
    // Здесь можно добавить логику для смены пароля
    // Например, проверка старого пароля и сохранение нового пароля
    print('Password changed');
    _oldPasswordController.clear();
    _newPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 2,
      cart: widget.cart,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(_isEditing ? Icons.check : Icons.edit),
              onPressed: () {
                if (_isEditing) {
                  _saveUserData();
                } else {
                  setState(() {
                    _isEditing = true;
                  });
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _isEditing
                  ? TextField(controller: _emailController)
                  : Text(email ?? '', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              Text('Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _isEditing
                  ? TextField(controller: _nameController)
                  : Text(name ?? '', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              if (_isEditing) ...[
                Text('Change Password',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(labelText: 'Old Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _changePassword,
                  child: Text('Change Password'),
                ),
              ],
              SizedBox(height: 16),
              Text('Purchase History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: purchaseHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(purchaseHistory[index]['product']),
                      subtitle: Text(purchaseHistory[index]['date']),
                      trailing: Text(
                          '\$${purchaseHistory[index]['price'].toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
