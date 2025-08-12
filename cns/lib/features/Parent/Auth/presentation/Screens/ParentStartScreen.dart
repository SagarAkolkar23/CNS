// lib/features/parents/presentation/screens/parent_start_screen.dart
import 'package:cns/features/Parent/Auth/presentation/provider/ParentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ParentStartScreen extends ConsumerStatefulWidget {
  const ParentStartScreen({super.key});

  @override
  ConsumerState<ParentStartScreen> createState() => _ParentStartScreenState();
}

class _ParentStartScreenState extends ConsumerState<ParentStartScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBranch;
  String? _selectedYear;

  final List<String> branches = ['CSE', 'ECE', 'MECH', 'CIVIL', 'ENTC', 'AIML'];
  final List<String> years = ['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(parentsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Get Started (Parent)')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedBranch,
                decoration: const InputDecoration(labelText: 'Select Branch'),
                items: branches
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedBranch = v),
                validator: (v) => v == null ? 'Please select branch' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedYear,
                decoration: const InputDecoration(labelText: 'Select Year'),
                items: years
                    .map(
                      (y) => DropdownMenuItem(value: y, child: Text('Year $y')),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedYear = v),
                validator: (v) => v == null ? 'Please select year' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : _onStartPressed,
                  child: state.isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Start'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onStartPressed() async {
    if (!_formKey.currentState!.validate()) return;
    final branch = _selectedBranch!;
    final year = _selectedYear!;
    await ref
        .read(parentsControllerProvider.notifier)
        .register(branch: branch, year: year);

    // if successful, navigate to home
    final state = ref.read(parentsControllerProvider);
    if (state is AsyncData) {
      if (!mounted) return;
      context.go("/Parent/HomeScreen");
    } else if (state is AsyncError) {
      final err = state.error;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registration failed: $err')));
    }
  }
}
