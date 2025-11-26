import 'package:airnav_helpdesk/core/widgets/app_bar_widget.dart';
import 'package:airnav_helpdesk/core/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ticket_list_controller.dart';
import '../widget/ticket_card.dart';

class TicketListPage extends StatefulWidget {
  const TicketListPage({super.key});

  @override
  State<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends State<TicketListPage>
    with SingleTickerProviderStateMixin {
  late final TicketListController controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<TicketListController>();
    _tabController = TabController(vsync: this, length: controller.tabs.length);

    // Syncs TabController (swipe/tap) -> GetX controller
    _tabController.addListener(() {
      final newIndex = _tabController.index;
      if (controller.activeTab.value != controller.tabs[newIndex]) {
        controller.changeTab(controller.tabs[newIndex]);
      }
    });

    // Syncs GetX controller -> TabController
    // Ensures UI updates if the state is changed from elsewhere
    ever(controller.activeTab, (String activeTab) {
      final newIndex = controller.tabs.indexOf(activeTab);
      if (newIndex != -1 && _tabController.index != newIndex) {
        _tabController.animateTo(newIndex);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBarWidget(titleText: 'Tiket Saya'),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildTabs(), // Now uses a standard TabBar for smooth animation
          const SizedBox(height: 8),
          SearchField(
            onChanged: controller.onSearch,
            hintText: 'Cari tiket...',
          ),
          _buildFilterBar(),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: controller.tabs.map((_) {
                return Obx(() {
                  final list = controller.tickets;
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: list.length,
                    itemBuilder: (_, i) => TicketCard(
                      ticket: list[i],
                      activeTab: controller.activeTab.value,
                    ),
                  );
                });
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToNewTicket,
        backgroundColor: const Color(0xFF0D47A1),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _filterDropdown(
            label: "Status",
            value: controller.statusFilter.value,
            items: const ['', 'Done', 'In Progress', 'Assigned', 'New'],
            onChanged: controller.setStatusFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "Priority",
            value: controller.priorityFilter.value,
            items: const ['', 'Critical', 'High', 'Medium', 'Low'],
            onChanged: controller.setPriorityFilter,
          ),
          const SizedBox(width: 10),
          _filterDropdown(
            label: "Sort",
            value: controller.sortOption.value,
            items: const ['date_desc', 'date_asc', 'priority', 'progress'],
            onChanged: controller.setSortOption,
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(() {
            final reactiveValue = (label == "Status")
                ? controller.statusFilter.value
                : (label == "Priority")
                ? controller.priorityFilter.value
                : controller.sortOption.value;

            return PopupMenuButton<String>(
              offset: const Offset(0, 50),
              onSelected: (val) => onChanged(val),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              itemBuilder: (BuildContext context) {
                return items.map((String item) {
                  final isSelected =
                      (item.isEmpty && reactiveValue.isEmpty) ||
                          item == reactiveValue;
                  return PopupMenuItem<String>(
                    value: item,
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: constraints.maxWidth,
                      color: isSelected ? Colors.grey[200] : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: Text(item.isEmpty ? 'All' : item),
                    ),
                  );
                }).toList();
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF135CA1),
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: Get.theme.cardColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      reactiveValue.isEmpty ? 'All' : reactiveValue,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  // Switched to TabBar for seamless sliding animation like in notification_page
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        // Style replication from original design
        labelColor: const Color(0xFF135CA1),
        unselectedLabelColor: const Color(0xFF475569),
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        // Reduced vertical padding to decrease height
        labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),

        // Indicator style for smooth sliding
        indicatorColor: const Color(0xFF135CA1),
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,

        // Remove splash to feel more like the original
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),

        tabs: controller.tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}
