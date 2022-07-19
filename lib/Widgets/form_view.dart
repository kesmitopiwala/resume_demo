import 'package:flutter/material.dart';
import 'package:resume_demo/Widgets/education_history.dart';
import 'package:resume_demo/Widgets/employment_history.dart';
import 'package:resume_demo/Widgets/extra_curriculars.dart';
import 'package:resume_demo/Widgets/languages.dart';
import 'package:resume_demo/Widgets/links.dart';
import 'package:resume_demo/Widgets/personal_details.dart';
import 'package:resume_demo/Widgets/profile_summary.dart';
import 'package:resume_demo/Widgets/skills.dart';

class FormSide extends StatefulWidget {
  const FormSide({Key? key}) : super(key: key);

  @override
  State<FormSide> createState() => _FormSideState();
}

class _FormSideState extends State<FormSide> {
  String? name;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            PersonalDetails(),
            SizedBox(height: 8),
            ProfileSummary(),
            SizedBox(height: 8),
            LinksInfo(),
            SizedBox(height: 8),
            EmploymentHistory(),
            SizedBox(height: 8),
            EducationHistory(),
            SizedBox(height: 8),
            SkillsInfo(),
            SizedBox(height: 8),
            Extracurriculars(),
            SizedBox(height: 8),
            LanguagesInfo(),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
