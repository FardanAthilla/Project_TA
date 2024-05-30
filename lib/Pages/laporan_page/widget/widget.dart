import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/color.dart';

class DateController extends GetxController {
  var date = ''.obs;

  void setDate(DateTime picked) {
    date.value = DateFormat('yyyy-MM-dd').format(picked);
  }

  void clear() {
    date.value = '';
  }
}

class DateTextField extends StatelessWidget {
  final String title;
  final String description;
  final DateController dateController;
  final FocusNode? focusNode;

  DateTextField({
    Key? key,
    required this.title,
    required this.description,
    required this.dateController,
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
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
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
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Warna.main,
                            surface:
                                Colors.white,
                          ),
                          dialogBackgroundColor:
                              Warna.teksactive, 
                        ),
                        child: child!,
                      );
                    },
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
                    borderSide: BorderSide(color: Warna.main),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              )),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBarButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;

  const BottomBarButton({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              side: BorderSide(color: borderColor, style: BorderStyle.solid),
              minimumSize: Size(double.infinity, 40),
              padding: EdgeInsets.symmetric(vertical: 10.0)),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
