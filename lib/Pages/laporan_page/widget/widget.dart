import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/color.dart';

class DateController extends GetxController {
  var displayDate = ''.obs;
  var apiDate = ''.obs;

  void setDate(DateTime picked) {
    displayDate.value =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(picked);
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
      lastDate: DateTime.now(),
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
                controller:
                    TextEditingController(text: controller.displayDate.value),
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
  final String subtitle;
  final TextEditingController controller;
  final int maxLines;
  final int maxLength;
  final TextInputType inputType;

  EditableTextField({
    required this.title,
    required this.subtitle,
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
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          inputFormatters: inputType == TextInputType.number
              ? [ThousandsSeparatorInputFormatter()]
              : null,
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
        const SizedBox(height: 15),
      ],
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,##0", "id_ID");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('.', '');
    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int value = int.parse(newText);
    String formattedText = _formatter.format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
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
