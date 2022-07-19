import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:resume_demo/Controllers/resume_edit_controller.dart';
import 'package:resume_demo/Models/pdf_model.dart';
import 'package:resume_demo/Utils/constants.dart';
import 'package:resume_demo/Utils/custom_widget.dart';
import 'package:resume_demo/Widgets/buttons.dart';

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
                    LogoAndTitleRow(),
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
              LogoAndTitleColumn(),
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
          child: Container(
            color: AppColor.whiteColor,
            height: 400,
            child: Center(child: CustomWidget.text("Resume Builder App")),
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

                    Get.toNamed('/resume');
                  },
                  text: 'Continue without signing in'),
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

class LogoAndTitleRow extends StatelessWidget {
  const LogoAndTitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(36),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: CustomWidget.roundedShapeAll(20),
              color: AppColor.whiteColor
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidget.text(
                'CREATE A FREE RESUME NOW!',
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LogoAndTitleColumn extends StatelessWidget {
  const LogoAndTitleColumn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(36),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: CustomWidget.roundedShapeAll(20),
              color: AppColor.whiteColor
            ),
          ),
          CustomWidget.text(
            'CREATE A FREE RESUME NOW!',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColor.primaryColor
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

