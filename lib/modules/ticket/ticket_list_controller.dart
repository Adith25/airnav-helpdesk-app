import 'package:airnav_helpdesk/modules/ticket/ticket_model.dart';
import 'package:get/get.dart';

class TicketListController extends GetxController {
  // observable list of tickets
  RxList<TicketModel> tickets = <TicketModel>[].obs;

  // search keyword
  RxString keyword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyTickets();
  }

  void onSearch(String value) {
    keyword.value = value;
    // implement filtering when real API arrives
  }

  void goToNewTicket() {
    // route later
    Get.snackbar('Navigation', 'Go to new ticket page (to be implemented)');
  }

  void loadDummyTickets() {
    tickets.value = [
      TicketModel(
        code: 'T20250311W079',
        title: 'Tidak bisa connect ke VPN kantor',
        date: '2025-03-13 12:17:31',
        category: 'NETWORK',
        subCategory: 'VPN & REMOTE ACCESS',
        progress: 100,
        status: 'SOLVED',
        priority: 'Medium',
        lastUpdate: '16 Mar 2025, 12.17',
        lastUpdateStatus: 'Done',
      ),
      TicketModel(
        code: 'T20250923W393',
        title: 'Printer tidak bisa print warna',
        date: '2025-09-23 14:38:23',
        category: 'HARDWARE',
        subCategory: 'PRINTER & SCANNER',
        progress: 100,
        status: 'SOLVED',
        priority: 'Low',
        lastUpdate: '26 Sep 2025, 14.38',
        lastUpdateStatus: 'Done',
      ),
      TicketModel(
        code: 'T20250615W456',
        title: 'Aplikasi ERP error saat login',
        date: '2025-06-15 09:22:15',
        category: 'SOFTWARE',
        subCategory: 'APPLICATION ERROR',
        progress: 50,
        status: 'ON PROCESS',
        priority: 'High',
        lastUpdate: '18 Jun 2025, 09.22',
        lastUpdateStatus: 'In Progress',
      ),
      TicketModel(
        code: 'T20250420W789',
        title: 'Laptop lemot dan sering hang',
        date: '2025-04-20 16:45:30',
        category: 'HARDWARE',
        subCategory: 'COMPUTER & LAPTOP',
        progress: 50,
        status: 'ON PROCESS',
        priority: 'Medium',
        lastUpdate: '23 Apr 2025, 16.45',
        lastUpdateStatus: 'Assigned',
      ),
      TicketModel(
        code: 'T20250301W123',
        title: 'Internet kantor sangat lambat',
        date: '2025-03-01 08:30:45',
        category: 'NETWORK',
        subCategory: 'INTERNET CONNECTION',
        progress: 0,
        status: 'WAITING',
        priority: 'Critical',
        lastUpdate: '04 Mar 2025, 08.30',
        lastUpdateStatus: 'New',
      ),
    ];
  }
}
