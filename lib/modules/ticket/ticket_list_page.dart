import 'package:airnav_helpdesk/modules/ticket/ticket_list_controller.dart';
import 'package:airnav_helpdesk/modules/ticket/widget/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketListPage extends GetView<TicketListController> {
  const TicketListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          _buildTabs(),
          _buildSearchField(),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              final list = controller.tickets;
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: list.length,
                itemBuilder: (_, i) => TicketCard(ticket: list[i]),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToNewTicket,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTabs() {
    // Obx removed from here as it wasn't observing any reactive state.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _tabItem('My Tickets', true, () {}),
          const SizedBox(width: 20),
          _tabItem('New Ticket', false, controller.goToNewTicket),
        ],
      ),
    );
  }

  Widget _tabItem(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: active ? const Color(0xFF135CA1) : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (active)
            Container(
              height: 2,
              width: 60,
              color: const Color(0xFF135CA1),
            )
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: TextField(
        onChanged: controller.onSearch,
        decoration: InputDecoration(
          hintText: 'Search tickets...',
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          prefixIcon: const Icon(Icons.search, size: 20),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
      ),
    );
  }
}