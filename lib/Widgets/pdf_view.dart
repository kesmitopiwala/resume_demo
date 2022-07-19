import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:resume_demo/Controllers/resume_edit_controller.dart';
import 'package:resume_demo/Template/templates.dart';
import 'package:resume_demo/Utils/constants.dart';

class PdfDisplay extends ConsumerStatefulWidget {
  final bool useMobileLayout;
  const PdfDisplay(this.useMobileLayout, {Key? key}) : super(key: key);

  @override
  _PdfDisplayState createState() => _PdfDisplayState();
}

class _PdfDisplayState extends ConsumerState<PdfDisplay>  with AutomaticKeepAliveClientMixin{

    @override
  bool get wantKeepAlive => true;

    @override
  void initState() {
   super.initState();
  }
  @override
  Widget build(BuildContext context)  {
       super.build(context);
    final _pdfProvider = ref.watch(pdfProvider);

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Theme(
        data: ThemeData(
            primaryColor: AppColor.whiteColor, primaryIconTheme: const IconThemeData(color: AppColor.primaryColor)),
        child: Center(
          child: SizedBox(
            height:  widget.useMobileLayout ? MediaQuery.of(context).size.height - 156 :  MediaQuery.of(context).size.height - 80,
            child: PdfPreview(
              scrollViewDecoration: const BoxDecoration(
                color: AppColor.primaryColor,
              ),
              pdfPreviewPageDecoration: const BoxDecoration(),
              useActions: false,
              maxPageWidth: widget.useMobileLayout ? null : MediaQuery.of(context).size.width / 2 - (80),
              allowPrinting: true,
              allowSharing: true,
              canDebug: false,
              canChangeOrientation: false,
              canChangePageFormat: false,
              build: (format) => generateDocument(context, pdfModel: _pdfProvider),
            ),
          ),
        ),
      ),
    );
  }
}
