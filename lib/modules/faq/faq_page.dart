import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'faq_controller.dart';

class FaqPage extends GetView<FaqController> {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ShadInput(
                  placeholder: const Text('Search FAQ...'),
                  onChanged: controller.setSearchQuery,
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children: controller.categories.map((category) {
                        final isSelected =
                            controller.selectedCategory.value == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () => controller.setCategory(category),
                            child: ShadBadge(
                              backgroundColor: isSelected
                                  ? Colors.black
                                  : Colors.grey.shade200,
                              foregroundColor: isSelected
                                  ? Colors.white
                                  : Colors.black,
                              child: Text(category),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(
                () => ShadAccordion<int>(
                  children: controller.filteredItems.asMap().entries.map((
                    entry,
                  ) {
                    final index = entry.key;
                    final item = entry.value;
                    return ShadAccordionItem(
                      value: index,
                      title: Text(
                        item.question,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: Text(
                        item.answer,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
