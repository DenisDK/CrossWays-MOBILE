import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditTripDialog extends StatefulWidget {
  final String tripDescription;
  final String formattedStartDate;
  final String formattedEndDate;
  final int memberLimit;

  const EditTripDialog({
    Key? key,
    required this.tripDescription,
    required this.formattedStartDate,
    required this.formattedEndDate,
    required this.memberLimit,
  }) : super(key: key);

  @override
  State<EditTripDialog> createState() => _EditTripDialogState();
}

class _EditTripDialogState extends State<EditTripDialog> {
  late TextEditingController descriptionController;
  late TextEditingController memberLimitController;
  DateTime? startDate;
  DateTime? endDate;
  String? memberLimitError;
  String? descriptionError;

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController(text: widget.tripDescription);
    memberLimitController =
        TextEditingController(text: widget.memberLimit.toString());

    startDate = DateFormat('dd-MM-yyyy').parse(widget.formattedStartDate);
    endDate = DateFormat('dd-MM-yyyy').parse(widget.formattedEndDate);

    _validateDescription(widget.tripDescription);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    memberLimitController.dispose();
    super.dispose();
  }

  bool _isValidMemberLimit(String value) {
    final number = int.tryParse(value);
    return number != null && number >= 1;
  }

  void _validateMemberLimit(String value) {
    setState(() {
      if (value.isEmpty) {
        memberLimitError = 'Member limit is required';
      } else if (!_isValidMemberLimit(value)) {
        memberLimitError = 'Minimum 1 member required';
      } else {
        memberLimitError = null;
      }
    });
  }

  void _validateDescription(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        descriptionError = 'Description is required';
      } else {
        descriptionError = null;
      }
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    final DateTime initialDate = isStartDate
        ? (startDate!.isBefore(tomorrow) ? tomorrow : startDate!)
        : (endDate!.isBefore(tomorrow) ? tomorrow : endDate!);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: tomorrow,
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate!.isBefore(startDate!)) {
            endDate = picked;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Trip',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B6857),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              maxLines: 13,
              onChanged: _validateDescription,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: const TextStyle(
                  color: Color(0xFF8B6857),
                ),
                errorText: descriptionError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B6857),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B6857),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B6857),
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text(
                      'Start Date: ${DateFormat('dd-MM-yyyy').format(startDate!)}',
                      style: const TextStyle(color: Color(0xFF8B6857)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text(
                      'End Date: ${DateFormat('dd-MM-yyyy').format(endDate!)}',
                      style: const TextStyle(color: Color(0xFF8B6857)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: memberLimitController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: _validateMemberLimit,
              decoration: InputDecoration(
                labelText: 'Member Limit',
                labelStyle: const TextStyle(
                  color: Color(0xFF8B6857),
                ),
                errorText: memberLimitError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B6857),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B6857),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B6857),
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xFF8B6857)),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B6857),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _validateDescription(descriptionController.text);
                    _validateMemberLimit(memberLimitController.text);

                    if (memberLimitError != null ||
                        descriptionError != null ||
                        !_isValidMemberLimit(memberLimitController.text) ||
                        descriptionController.text.trim().isEmpty) {
                      return;
                    }

                    Navigator.pop(context, {
                      'description': descriptionController.text.trim(),
                      'from': DateFormat('dd-MM-yyyy').format(startDate!),
                      'to': DateFormat('dd-MM-yyyy').format(endDate!),
                      'memberLimit': int.parse(memberLimitController.text),
                    });
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
