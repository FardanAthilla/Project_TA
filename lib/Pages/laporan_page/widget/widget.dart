import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/color.dart';

class DateController extends GetxController {
  var displayDate = ''.obs;
  var apiDate = ''.obs;

  void setDate(DateTime picked) {
    displayDate.value = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(picked);
    apiDate.value = DateFormat('yyyy-MM-dd').format(picked);
  }

  void clear() {
    displayDate.value = '';
    apiDate.value = '';
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('id', 'ID'),
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: Transform.scale(
            scale: 0.9,
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Warna.main,
                  surface: Colors.white,
                ),
                dialogBackgroundColor: Warna.main,
              ),
              child: child!,
            ),
          ),
        );
      },
    );

    if (picked != null) {
      controller.setDate(picked);
    }
  }

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
                controller: TextEditingController(text: controller.displayDate.value),
                onTap: () => _selectDate(context),
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

class EditableTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int maxLines;
  final int maxLength;
  final TextInputType inputType;

  EditableTextField({
    required this.title,
    required this.controller,
    this.maxLines = 1,
    required this.maxLength,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Warna.mainblue),
                ),
                suffixIcon: Icon(Icons.edit),
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Warna.main,
                ),
              ),
              maxLines: maxLines,
              minLines: maxLines,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Warna.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Masukkan Data',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Warna.hitam,
                    ),
                  ),
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Warna.hitam,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                keyboardType: inputType,
                decoration: InputDecoration(
                  fillColor: Warna.background,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Warna.main),
                  ),
                ),
                style: TextStyle(
                  color: Warna.hitam,
                ),
                maxLines: maxLines,
                maxLength: maxLength,
                onSubmitted: (value) {
                  if (value.length > maxLength) {
                    controller.text = value.substring(0, maxLength);
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: maxLength),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Batal',
                      style: TextStyle(
                        color: Warna.danger,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.main,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(color: Warna.background),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReadOnlyTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int maxLines;

  ReadOnlyTextField({
    required this.title,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Warna.mainblue),
            ),
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Warna.main,
            ),
          ),
          maxLines: maxLines,
          minLines: maxLines,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
