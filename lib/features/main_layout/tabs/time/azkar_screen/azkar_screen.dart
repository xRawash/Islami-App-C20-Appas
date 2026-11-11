import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/assets_manager.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';
import 'package:quran_app_abbas/features/main_layout/tabs/time/azkar_screen/load_azkar/load_azkar.dart';
import 'package:quran_app_abbas/models/azkar_item.dart';
import 'package:quran_app_abbas/models/azkar_model.dart';

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  late AzkarModel azkarModel;
  List<AzkarItem> azkarList = [];
  List<ValueNotifier<int>> countNotifiers = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    azkarModel = ModalRoute.of(context)!.settings.arguments as AzkarModel;
    if (azkarList.isEmpty) {
      _loadAzkarData();
    }
  }

  Future<void> _loadAzkarData() async {
    List<AzkarItem> list = await LoadAzkar.loadAzkar(azkarModel.id);
    if (mounted) {
      setState(() {
        azkarList = list;
        countNotifiers = list
            .map((item) => ValueNotifier<int>(item.initialCount))
            .toList();
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    for (var notifier in countNotifiers) {
      notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(azkarModel.name),
      ),
      body: Stack(
        children: [
          Image.asset(
            ImageAssets.timeBg,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorsManager.gold,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: azkarList.length,
                  itemBuilder: (context, index) {
                    final item = azkarList[index];
                    final countNotifier = countNotifiers[index];

                    return Card(
                      color: ColorsManager.black,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: ColorsManager.gold,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item.content,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.6,
                              ),
                            ),
                            if (item.description.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                item.description,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  color: ColorsManager.gold,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                            if (item.reference.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                item.reference,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  color: ColorsManager.ofWhite,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            ValueListenableBuilder<int>(
                              valueListenable: countNotifier,
                              builder: (context, remainingCount, child) {
                                final bool isCompleted = remainingCount == 0;
                                return InkWell(
                                  onTap: () {
                                    if (remainingCount > 0) {
                                      countNotifier.value = remainingCount - 1;
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isCompleted
                                          ? Colors.green
                                          : ColorsManager.gold,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (isCompleted) ...[
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            "مكتمل",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ] else ...[
                                          Text(
                                            "تكرار: $remainingCount",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
