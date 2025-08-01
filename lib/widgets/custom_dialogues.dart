import 'package:flutter/material.dart';

class CustomDialogues {
  static Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false, // must tap button
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: const [
                Icon(Icons.exit_to_app_rounded, color: Colors.deepPurple),
                SizedBox(width: 10),
                Text(
                  "Exit Session?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            content: const Text(
              "Your progress will be lost. Are you sure you want to exit the current yoga session?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[200],
                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel", style: TextStyle(fontSize: 16)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Exit", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ) ??
        false;
  }
}
