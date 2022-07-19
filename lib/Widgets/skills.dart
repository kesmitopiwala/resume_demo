import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resume_demo/Controllers/resume_edit_controller.dart';
import 'package:resume_demo/Models/pdf_model.dart';
import 'package:resume_demo/Utils/common_methods.dart';
import 'package:resume_demo/Utils/constants.dart';
import 'package:resume_demo/Utils/custom_widget.dart';
import 'package:resume_demo/Widgets/buttons.dart';
import 'package:resume_demo/Widgets/expansion.dart';
import 'package:resume_demo/Widgets/textfield.dart';

class SkillsInfo extends ConsumerWidget {
  const SkillsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _pdfProvider = ref.watch(pdfProvider);

    List<Skill> skillsList = _pdfProvider.skills!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 10,
            ),
            child: CustomWidget.text(
              'Your Skills',
              fontWeight: FontWeight.w600,
                fontSize: 20
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  key: Key(skillsList[index].skillId),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SkillFullWidget(
                    skill: skillsList[index],
                    onPressed: () {
                      ref.read(pdfProvider.notifier).removeSkill(skillsList[index]);
                    },
                  ),
                );
              },
              itemCount: skillsList.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SimpleElevatedButton(
                buttonWidth: double.infinity,
                onPressed: () {
                  ref.read(pdfProvider.notifier).addSkill(Skill.createEmpty());
                },
                text: 'Add another skill'),
          )
        ],
      ),
    );
  }
}

class SkillFullWidget extends ConsumerStatefulWidget {
  const SkillFullWidget({
    Key? key,
    required this.skill,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Skill skill;

  @override
  _SectionFullWidgetState createState() => _SectionFullWidgetState();
}

class _SectionFullWidgetState extends ConsumerState<SkillFullWidget> {
  TextEditingController skillNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        if (checkChangeText(skillNameController.text, widget.skill.skillName)) {
          skillNameController.text = widget.skill.skillName ?? "";
        }
      });
    });

    return BorderedExpansionTile(
      title: widget.skill.skillName ?? "Test",
      children: [
        RectBorderFormField(
          textEditingController: skillNameController,
          labelText: 'Skill Name',
          onTextChanged: (val) {
            ref.read(pdfProvider.notifier).editSkill(widget.skill.copyWith(skillName: val));
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SimpleOutlinedButton(
              color: AppColor.redColor,
              buttonWidth: double.infinity,
              onPressed: () => widget.onPressed(),
              text: 'Remove this skill'),
        )
      ],
    );
  }
}
