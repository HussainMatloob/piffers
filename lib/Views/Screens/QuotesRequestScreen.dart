import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/form_controller.dart';

class QuoteRequestScreen extends StatelessWidget {
  final controller = Get.put(FormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Quote Request',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              buildTextField('Name', controller.nameController),
              buildTextField('Company Name', controller.companyNameController),
              buildTextField('Subject', controller.subjectController),
              buildTextField('Email', controller.emailController, TextInputType.emailAddress),
              buildTextField('Phone No.', controller.phoneController, TextInputType.phone),
              Obx(() => Padding(
                padding: EdgeInsets.all(10),
                child: DropdownButtonFormField<String>(
                  value: controller.selectedService.value.isEmpty
                      ? null
                      : controller.selectedService.value,
                  decoration: InputDecoration(
                    labelText: 'Services',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16), // Updated to 16 for rounded corners
                    ),
                  ),
                  items: ['Service 1', 'Service 2', 'Service 3']
                      .map((service) => DropdownMenuItem(
                    value: service,
                    child: Text(service),
                  ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedService.value = value ?? '';
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a service';
                    }
                    return null;
                  },
                ),
              )),


              Obx(() => CheckboxListTile(
                title: Text('Need Calendar'),
                value: controller.needCalendar.value,
                onChanged: (value) {
                  controller.needCalendar.value = value ?? false;
                },
              )),
              buildTextField('Postal Address', controller.postalAddressController),
              buildTextField('Message', controller.messageController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.submitForm,
                child: Text('Submit', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildTextField(String label, TextEditingController controller,
      [TextInputType? inputType, bool obscureText = false]) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.nunitoSans(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: inputType ?? TextInputType.text,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.blueGrey), // Text color set to white
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Added corner radius here
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Same corner radius
                borderSide: const BorderSide(color: Colors.grey), // Default border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), // Same corner radius
                borderSide: const BorderSide(color: Colors.red, width: 2), // Focused border color
              ),
              fillColor: Colors.transparent,
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

}
