import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  var date = ''.obs;

  void setDate(DateTime picked) {
    date.value = DateFormat('yyyy-MM-dd').format(picked);
  }
}

class DateTextField extends StatelessWidget {
  final String title;
  final String description;
  final FocusNode? focusNode;

  DateTextField({
    Key? key,
    required this.title,
    required this.description,
    this.focusNode,
  }) : super(key: key);

  final DateController controller = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Obx(() => TextFormField(
                focusNode: focusNode,
                readOnly: true,
                controller: TextEditingController(text: controller.date.value),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    controller.setDate(picked);
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              )),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}