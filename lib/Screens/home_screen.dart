import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:resume_demo/Controllers/resume_edit_controller.dart';
import 'package:resume_demo/Models/pdf_model.dart';
import 'package:resume_demo/Utils/constants.dart';
import 'package:resume_demo/Utils/custom_widget.dart';
import 'package:resume_demo/Widgets/buttons.dart';
import 'package:resume_demo/Routes/route.dart' as rt;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(body: Center(child: LayoutBuilder(
      builder: (context, size) {
        if (size.maxWidth > 750) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: 850,
              height: 600,
              child: Card(
                color: AppColor.primaryColor,
                elevation: 8,
                shape: CustomWidget.roundedRectangleBorderAll(20),
                shadowColor: Colors.black.withOpacity(0.4),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          LoginButton(false),
                          ExampleImage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Container(
          color: AppColor.primaryColor,
          child: Column(
            children: const [
              ExampleImage(),
              SizedBox(height: 16),
              LoginButton(true),
            ],
          ),
        );
      },
    )));
  }
}

class ExampleImage extends StatelessWidget {
  const ExampleImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        color: AppColor.primaryColor,
        child: Center(
          child: Image.asset(
            "assets/logo.png",
            height: 400,
          ),
        ),
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  final bool useMobileLayout;
  const LoginButton(
      this.useMobileLayout, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: useMobileLayout
              ? CustomWidget.roundedShapeOnly(topRight: 20, topLeft: 20)
              : CustomWidget.roundedShapeOnly(topRight: 20, bottomRight: 20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleElevatedButton(
                  color: AppColor.whiteColor,
                  textColor: AppColor.primaryColor,
                  buttonHeight: 50,
                  buttonWidth: double.infinity,
                  roundedRadius: 5,
                  onPressed: () {
                    ref.watch(pdfProvider.notifier).editPdf(PdfModel.createEmpty().copyWith(pdfId: 'noSave'),);

                    Get.toNamed(rt.Route.resumeEditScreen);
                  },
                  text: 'Continue'),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


