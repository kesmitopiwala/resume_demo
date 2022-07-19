import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:resume_demo/Controllers/resume_edit_controller.dart';
import 'package:resume_demo/Models/pdf_model.dart';
import 'package:resume_demo/Models/pdf_model_data.dart';
import 'package:resume_demo/Template/templates.dart';
import 'package:resume_demo/Utils/constants.dart';
import 'package:resume_demo/Utils/custom_widget.dart';
import 'package:resume_demo/Widgets/buttons.dart';
import 'package:resume_demo/Widgets/form_view.dart';
import 'package:resume_demo/Widgets/pdf_view.dart';

import '../Utils/common_methods.dart';

class ResumeEditScreen extends ConsumerStatefulWidget {
  final String? uid;
  const ResumeEditScreen(this.uid, {Key? key}) : super(key: key);

  @override
  _ResumeEditScreenState createState() => _ResumeEditScreenState();
}

class _ResumeEditScreenState extends ConsumerState<ResumeEditScreen> with AutomaticKeepAliveClientMixin {
  late Timer timer;

  Future updateResume() async {
    PdfModel _pdfProvider = ref.read(pdfProvider);
    PdfModel _tempPdfProvider = ref.read(tempPdfProvider);

    if (widget.uid != null && _tempPdfProvider != _pdfProvider) {
      DateTime dateTime = DateTime.now();
      PdfModel pdfModel = _pdfProvider.copyWith(lastUpdated: dateTime);

      ref.watch(pdfProvider.notifier).editPdf(pdfModel);
      ref.watch(tempPdfProvider.notifier).state = pdfModel;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      updateResume();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Widget> actionButton() {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SimpleOutlinedButton(
              onPressed: () async {
                ref.read(pdfProvider.notifier).editPdf(pdfModelData);
              },
              text: 'Fill'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SimpleOutlinedButton(
              onPressed: () async {
                await Printing.sharePdf(
                    bytes: await generateDocument(context, pdfModel: ref.read(pdfProvider)), filename: 'resume.pdf');
              },
              text: 'Download'),
        ),
        if (widget.uid != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SimpleOutlinedButton(
                onPressed: () async {
                  try {
                    DateTime dateTime = DateTime.now();
                    PdfModel pdfModel = ref.watch(pdfProvider).copyWith(lastUpdated: dateTime);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: CustomWidget.text(
                          'Your resume was saved!',
                          color: AppColor.whiteColor,
                        )));
                  } catch (e) {
                    log(e.toString());
                  }
                },
                text: 'Save (' + timeAgoSinceDate(ref.watch(pdfProvider).lastUpdated) + ")"),
          ),
      ];
    }

    AppBar resumeAppbar() {
      return AppBar(
        iconTheme: const IconThemeData(color: AppColor.primaryColor),
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              if (widget.uid == null) {
                Get.offAndToNamed('/');
              } else {
                Get.offAndToNamed('home');
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.primaryColor,
            )),
        title: CustomWidget.text(
          'Resume Builder',
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColor.whiteColor,
        shadowColor: Colors.black.withOpacity(0.3),
        elevation: 8,
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 900) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: AppColor.primaryColor,
              appBar: AppBar(
                backgroundColor: AppColor.whiteColor,
                iconTheme: const IconThemeData(color: AppColor.primaryColor),
                centerTitle: false,
                title: CustomWidget.text(
                  'Resume Builder',
                  fontWeight: FontWeight.bold,
                ),
                bottom: TabBar(
                  labelStyle: CustomWidget().subtitle14.copyWith(color: AppColor.primaryColor),
                  labelColor: AppColor.primaryColor,
                  unselectedLabelColor: Colors.grey.shade400,
                  unselectedLabelStyle:CustomWidget().subtitle14.copyWith(color: Colors.grey.shade400),
                  tabs: const [
                    Tab(
                      text: 'Edit',
                    ),
                    Tab(
                      text: 'Preview',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Center(
                      child: Container(
                        height: double.infinity,
                        color: AppColor.whiteColor,
                        child: const FormSide(),
                      )),
                  Scaffold(
                    backgroundColor: AppColor.primaryColor,
                    body: const PdfDisplay(true),
                    bottomNavigationBar: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                        borderRadius: CustomWidget.roundedShapeOnly(topLeft: 20, topRight: 20),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: actionButton()),
                    ),
                  ),
                ],
              )),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColor.primaryColor,
          appBar: resumeAppbar(),
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 850),
                    height: double.infinity,
                    color: AppColor.whiteColor,
                    child: const FormSide(),
                  )),
              Flexible(
                  child: Center(
                    child: Scaffold(
                      backgroundColor: AppColor.primaryColor,
                      body: const PdfDisplay(false),
                      bottomNavigationBar: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: CustomWidget.roundedShapeOnly(topRight: 20),
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: actionButton()),
                      ),
                    ),
                  )),
            ],
          ),
        );
      }
    });
  }
}


