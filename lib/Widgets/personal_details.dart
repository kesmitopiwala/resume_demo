import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resume_demo/Controllers/resume_edit_controller.dart';
import 'package:resume_demo/Models/pdf_model.dart';
import 'package:resume_demo/Utils/common_methods.dart';
import 'package:resume_demo/Utils/custom_widget.dart';
import 'package:resume_demo/Widgets/textfield.dart';

class PersonalDetails extends ConsumerStatefulWidget {
  const PersonalDetails({
    Key? key,
  }) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends ConsumerState<PersonalDetails> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController jobRoleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _pdfProvider = ref.watch(pdfProvider);

    Personal personal = _pdfProvider.resumePersonal!;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        if (checkChangeText(emailController.text, personal.email)) {
          emailController.text = personal.email ?? "";
        }
        if (checkChangeText(phoneController.text, personal.phoneNumber)) {
          phoneController.text = personal.phoneNumber ?? "";
        }
        if (checkChangeText(firstNameController.text, personal.firstName)) {
          firstNameController.text = personal.firstName ?? "";
        }
        if (checkChangeText(lastNameController.text, personal.lastName)) {
          lastNameController.text = personal.lastName ?? "";
        }
        if (checkChangeText(jobRoleController.text, personal.jobTitle)) {
          jobRoleController.text = personal.jobTitle ?? "";
        }
      });
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomWidget.text(
              'Personal Details',
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),
          ),
          RectBorderFormField(
            textEditingController: emailController,
            initialValue: _pdfProvider.resumePersonal!.email,
            labelText: 'Email Address',
            onTextChanged: (val) {
              ref.read(pdfProvider.notifier).editPersonal(personal.copyWith(email: val));
            },
          ),
          Row(
            children: [
              Flexible(
                child: RectBorderFormField(
                  textEditingController: firstNameController,
                  initialValue: returnCorrectStringString(personal.firstName),
                  labelText: 'First Name',
                  onTextChanged: (val) {
                    ref.read(pdfProvider.notifier).editPersonal(personal.copyWith(firstName: val));
                  },
                ),
              ),
              Flexible(
                child: RectBorderFormField(
                  textEditingController: lastNameController,
                  initialValue: returnCorrectStringString(personal.lastName),
                  labelText: 'Last Name',
                  onTextChanged: (val) {
                    ref.read(pdfProvider.notifier).editPersonal(personal.copyWith(lastName: val));
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: RectBorderFormField(
                  textEditingController: jobRoleController,
                  initialValue: returnCorrectStringString(personal.jobTitle),
                  labelText: 'Job Role',
                  hintText: 'eg. Software Developer',
                  onTextChanged: (val) {
                    ref.read(pdfProvider.notifier).editPersonal(personal.copyWith(jobTitle: val));
                  },
                ),
              ),
              Flexible(
                child: RectBorderFormField(
                  textEditingController: phoneController,
                  initialValue: returnCorrectStringString(personal.email),
                  labelText: 'Phone Number',
                  onTextChanged: (val) {
                    ref.read(pdfProvider.notifier).editPersonal(personal.copyWith(phoneNumber: val));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
