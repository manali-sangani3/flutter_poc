import 'package:flutter/material.dart';

import '../services/secure_vault_service.dart';

class SecureVaultScreen extends StatefulWidget {
  const SecureVaultScreen({super.key});

  @override
  State<SecureVaultScreen> createState() => _SecureVaultScreenState();
}

class _SecureVaultScreenState extends State<SecureVaultScreen> {
  final vaultService = SecureVaultService();

  final controller = TextEditingController();

  String savedNote = '';

  Future<void> saveNote() async {
    await vaultService.saveNote(controller.text);

    controller.clear();

    loadNote();
  }

  Future<void> loadNote() async {
    final note = await vaultService.getNote();

    setState(() {
      savedNote = note;
    });
  }

  @override
  void initState() {
    super.initState();
    clearOldData();

    loadNote();
  }

  Future<void> clearOldData() async {
    await vaultService.storage.deleteAll();

    loadNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Secure Vault")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: controller,

              decoration: const InputDecoration(
                hintText: "Enter Secret Note",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: saveNote,

              child: const Text("Encrypt & Save"),
            ),

            const SizedBox(height: 30),

            const Text(
              "Decrypted Note",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Text(savedNote.isEmpty ? "No Note Saved" : savedNote),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
