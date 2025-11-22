import 'package:get/get.dart';

class FaqController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'All'.obs;

  final List<String> categories = ['All', 'General', 'Ticket', 'Account'];

  final RxList<FaqItem> faqItems = [
    FaqItem(
      question: 'Bagaimana cara membuat tiket baru?',
      answer:
          'Anda dapat membuat tiket baru dengan menekan tombol "Buat Tiket" di halaman utama, kemudian mengisi semua form yang diperlukan.',
      category: 'Ticket',
    ),
    FaqItem(
      question: 'Di mana saya bisa melihat status tiket saya?',
      answer:
          'Semua tiket yang pernah Anda buat akan tampil di halaman utama. Status setiap tiket akan terlihat jelas di masing-masing kartu tiket.',
      category: 'Ticket',
    ),
    FaqItem(
      question: 'Bagaimana cara mengubah prioritas tiket?',
      answer:
          'Setelah tiket dibuat, prioritas tidak dapat diubah. Pastikan Anda memilih prioritas yang sesuai saat membuat tiket.',
      category: 'Ticket',
    ),
    FaqItem(
      question: 'Apa saja kategori yang tersedia?',
      answer:
          'Kategori yang tersedia mencakup Jaringan, Perangkat Keras, Perangkat Lunak, dan lain-lain. Anda bisa melihat daftar lengkapnya di dropdown kategori pada halaman pembuatan tiket.',
      category: 'General',
    ),
  ].obs;

  List<FaqItem> get filteredItems {
    return faqItems.where((item) {
      final matchesSearch =
          item.question.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          item.answer.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesCategory =
          selectedCategory.value == 'All' ||
          item.category == selectedCategory.value;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onInit() {
    super.onInit();
  }
}

class FaqItem {
  final String question;
  final String answer;
  final String category;

  FaqItem({
    required this.question,
    required this.answer,
    required this.category,
  });
}
