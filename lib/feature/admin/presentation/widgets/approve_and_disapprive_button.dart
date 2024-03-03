import 'package:flutter/material.dart';

class ApproveOrDisapprove extends StatelessWidget {
  final VoidCallback onApproveTap;
  final VoidCallback onDisapproveTap;
  const ApproveOrDisapprove(
      {super.key, required this.onApproveTap, required this.onDisapproveTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onApproveTap,
              child: Container(
                height: 50,
                color: Colors.green,
                child: const Center(
                    child: Text(
                  "Approve",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: onDisapproveTap,
              child: Container(
                height: 50,
                color: Colors.red,
                child: const Center(
                    child: Text("Disapprove",
                        style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
