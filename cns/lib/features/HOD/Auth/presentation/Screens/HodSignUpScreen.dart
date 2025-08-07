import 'package:cns/features/HOD/Auth/presentation/Provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HodSignupScreen extends ConsumerStatefulWidget {
  const HodSignupScreen({super.key});

  @override
  ConsumerState<HodSignupScreen> createState() => _HodSignupScreenState();
}

class _HodSignupScreenState extends ConsumerState<HodSignupScreen> {
  final formKey = GlobalKey<FormState>();
  final uidController = TextEditingController();
  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void register() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        await ref
            .read(hodAuthControllerProvider.notifier)
            .hodRegisterUseCase(
              uid: uidController.text.trim(),
              name: nameController.text.trim(),
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              department: departmentController.text.trim(),
            );
        // Navigate to login page or dashboard
        // context.go('/hod_login');
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HOD Signup')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: uidController,
                decoration: const InputDecoration(labelText: 'HOD UID'),
                validator: (val) => val!.isEmpty ? 'HOD UID is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (val) => val!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
                validator: (val) =>
                    val!.isEmpty ? 'Department is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (val) =>
                    val!.isEmpty ? 'Email cannot be empty' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (val) =>
                    val!.length < 6 ? 'Password too short' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : register,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
