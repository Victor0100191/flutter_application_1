import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    color: Colors.blue, // Color azul
                    fontSize: 24, // Tamaño grande de la letra
                    fontWeight: FontWeight.bold, // Negrita (opcional)
                  ),
                ),
              ],
            ),
          ),
        ),
        body: const InputFormScreen(),
      ),
    );
  }
}

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({super.key});

  @override
  _InputFormScreenState createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  void _showInputs() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nombre: ${_nameController.text}\nEmail: ${_emailController.text}\nContraseña: ${_passwordController.text}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de nombre
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ingresa tu nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El nombre no puede estar vacío';
                }
                if (value.length < 5) {
                  return 'Debe contener al menos 5 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // Campo de email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Ingresa tu email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El email no puede estar vacío';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Ingresa un email válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // Campo de contraseña
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Ingresa tu contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La contraseña no puede estar vacía';
                }
                if (value.length < 6) {
                  return 'Debe tener al menos 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Formulario válido')),
                      );
                    }
                  },
                  child: const Text('Enviar'),
                ),
                ElevatedButton(
                  onPressed: _clearFields,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text('Limpiar'),
                ),
                ElevatedButton(
                  onPressed: _showInputs,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Mostrar Datos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
