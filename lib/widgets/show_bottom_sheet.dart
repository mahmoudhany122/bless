import 'package:flutter/material.dart';

mainShowDialog({
  required Widget page,
  required BuildContext context,
  required double height,
  bool isDismissible = true,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent,
    builder: (_) => LayoutBuilder(
      builder: (context, _) {
        return AnimatedPadding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: height,
              minHeight: height,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 71,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: page,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

mainShowBottomSheet({
  required Widget page,
  required BuildContext context,
  required double height,
  bool isDismissible = true,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent,
    builder: (_) => LayoutBuilder(
      builder: (context, _) {
        return AnimatedPadding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: height,
              minHeight: height,
            ),
            child: page,
          ),
        );
      },
    ),
  );
}