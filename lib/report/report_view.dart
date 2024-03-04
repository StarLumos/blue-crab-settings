part of 'package:bluetooth_detector/map_view/map_view.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  ReportViewState createState() => ReportViewState();
}

class ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.background,
        body: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.all(4),
                      child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)))
                ],
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Modal BottomSheet'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
