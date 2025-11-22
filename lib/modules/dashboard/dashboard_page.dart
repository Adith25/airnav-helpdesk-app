import 'package:airnav_helpdesk/modules/dashboard/models/help_request.dart';
import 'package:airnav_helpdesk/modules/dashboard/widgets/request_card.dart';
import 'package:airnav_helpdesk/modules/dashboard/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 72,
        title: const Text(
          'Helpdesk',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person_outline, color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Container(height: 4, color: Colors.black, width: double.infinity),
            const SizedBox(height: 14),

            // Availability + period
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ShadBadge.outline(child: const Text('Availability Status')),
                    const SizedBox(width: 12),
                    Obx(
                      () => ShadSwitch(
                        value: controller.availability.value,
                        onChanged: controller.setAvailability,
                      ),
                    ),
                  ],
                ),
                // period dropdown
                Obx(
                  () => ShadSelect<String>(
                    placeholder: const Text('Select Period'),
                    initialValue: controller.period.value,
                    options: const [
                      ShadOption(value: 'Monthly', child: Text('Monthly')),
                      ShadOption(value: 'Weekly', child: Text('Weekly')),
                      ShadOption(value: 'Daily', child: Text('Daily')),
                    ],
                    onChanged: (value) {
                      if (value != null) controller.setPeriod(value);
                    },
                    selectedOptionBuilder: (context, value) {
                      return Text(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.4,
              children: const [
                StatCard(
                  icon: Icons.phone_in_talk,
                  label: 'Completed Requests',
                  value: '0',
                ),
                StatCard(
                  icon: Icons.star_border,
                  label: 'Average Rating',
                  value: '0',
                ),
                StatCard(
                  icon: Icons.check_circle_outline,
                  label: 'Completed Requests',
                  value: '0',
                ),
                StatCard(
                  icon: Icons.star_border,
                  label: 'Average Rating',
                  value: '0',
                ),
              ],
            ),

            const SizedBox(height: 18),
            const Text(
              'Recent Help Requests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: const EdgeInsets.only(bottom: 18),
                  itemCount: controller.requests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final r = controller.requests[index];
                    return RequestCard(request: r);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
