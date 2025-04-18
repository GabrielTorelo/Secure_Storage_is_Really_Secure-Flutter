import 'package:flutter/material.dart';
import 'package:analysis_web/components/google_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:analysis_web/components/dialog/tip_dialog.dart';

class HomeDialog extends StatelessWidget {
  const HomeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return TipDialog(
      title: localizations.howAccessBrowserLS,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GoogleText(
            textBefore: localizations.accessBrowserDevTools,
            chrome: true,
            boldGoogle: true,
            periodGoogle: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              localizations.homeDialogStepOne,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildImageDialog(
            context,
            imagePath: 'assets/images/tips/localstorage/accessing_devtools.png',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              localizations.homeDialogStepTwo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildImageDialog(
            context,
            imagePath:
                'assets/images/tips/localstorage/accessing_localstorage.png',
          ),
        ],
      ),
    );
  }

  Widget _buildImageDialog(
    BuildContext context, {
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: InteractiveViewer(
                      panEnabled: true,
                      boundaryMargin: const EdgeInsets.all(100),
                      minScale: 0.5,
                      maxScale: 2,
                      child: Image.asset(imagePath),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Image.asset(imagePath),
      ),
    );
  }
}
