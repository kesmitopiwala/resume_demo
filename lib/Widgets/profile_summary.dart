import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resume_demo/Controllers/resume_edit_controller.dart';
import 'package:resume_demo/Models/pdf_model.dart';
import 'package:resume_demo/Utils/common_methods.dart';
import 'package:resume_demo/Utils/custom_widget.dart';
import 'package:resume_demo/Widgets/textfield.dart';

class ProfileSummary extends ConsumerStatefulWidget {
  const ProfileSummary({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileSummaryState createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends ConsumerState<ProfileSummary> {
  TextEditingController summaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _pdfProvider = ref.watch(pdfProvider);

    Summary summary = _pdfProvider.resumeSummary!;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        if (checkChangeText(summaryController.text, summary.professionalSummary)) {
          summaryController.text = summary.professionalSummary ?? "";
        }
      });
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
              top: 10,
            ),
            child: CustomWidget.text(
              'Profile',
              fontWeight: FontWeight.w600,
              fontSize: 20
            ),
          ),
          RectBorderFormField(
            textEditingController: summaryController,
            maxLines: 9,
            maxLength: 500,
            labelText: "Summary",
            hintText: 'eg. I am a motivated IT graduate looking forward...',
            onTextChanged: (val) {
              ref.read(pdfProvider.notifier).editSummary(summary.copyWith(professionalSummary: val));
            },
          ),
        ],
      ),
    );
  }
}
