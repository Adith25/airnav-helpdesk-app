import 'dart:io';

import 'package:airnav_helpdesk/modules/dashboard/dashboard_controller.dart';
import 'package:airnav_helpdesk/modules/dashboard/models/help_request.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTicketController extends GetxController {
  final Rxn<String> selectedDepartment = Rxn<String>();
  final Rxn<String> selectedCategory = Rxn<String>();
  final Rxn<String> selectedSubCategory = Rxn<String>();
  final Rxn<String> selectedSource = Rxn<String>();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxList<File> selectedFiles = <File>[].obs;

  final List<String> departments = ['IT', 'SDM', 'Keuangan', 'Teknik'];
  final List<String> categories = ['Permintaan Layanan', 'Insiden'];
  final List<String> subCategories = ['Akses Wifi', 'Kerusakan Printer'];
  final List<String> sources = ['Portal', 'Email', 'Telepon', 'Langsung'];

  void onDepartmentChanged(String? value) {
    selectedDepartment.value = value;
  }

  void onCategoryChanged(String? value) {
    selectedCategory.value = value;
    selectedSubCategory.value = null;
  }

  void onSubCategoryChanged(String? value) {
    selectedSubCategory.value = value;
  }

  void onSourceChanged(String? value) {
    selectedSource.value = value;
  }

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
        List<File> validFiles = [];
        bool hasLargeFile = false;

        for (var path in result.paths) {
          if (path != null) {
            final file = File(path);
            final int sizeInBytes = await file.length();
            final double sizeInMB = sizeInBytes / (1024 * 1024);

            if (sizeInMB <= 10) {
              validFiles.add(file);
            } else {
              hasLargeFile = true;
            }
          }
        }

        if (validFiles.isNotEmpty) {
          selectedFiles.addAll(validFiles);
        }

        if (hasLargeFile) {
          Get.snackbar(
            'Ukuran Berkas Terlalu Besar',
            'Beberapa berkas dilewati karena melebihi 10MB.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
        }
      }
    } catch (e) {
      if (e.toString().contains('MissingPluginException')) {
        Get.snackbar(
          'Diperlukan Mulai Ulang Aplikasi',
          'Mohon berhenti dan mulai ulang aplikasi untuk mengaktifkan pemilihan berkas.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      } else {
        Get.snackbar('Kesalahan', 'Gagal memilih berkas: $e');
      }
    }
  }

  void removeFile(int index) {
    selectedFiles.removeAt(index);
  }

  void submitTicket() {
    if (selectedDepartment.value != null &&
        selectedCategory.value != null &&
        subjectController.text.isNotEmpty) {
      try {
        final dashboardController = Get.find<DashboardController>();

        final newRequest = HelpRequest(
          name: 'Pengguna Saat Ini',
          title: subjectController.text,
          date: 'Baru saja',
          responseDue: 'Batas respons dalam 24 jam',
          tags: [
            'Sedang',
            '${selectedDepartment.value} / Umum',
          ],
          status: 'Terbuka',
          highlight: 'BARU',
          description: descriptionController.text,
        );

        dashboardController.requests.insert(0, newRequest);

        Get.snackbar(
          'Berhasil',
          'Tiket berhasil dikirim!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        _clearForm();

        Get.back();
      } catch (e) {
        Get.snackbar(
          'Kesalahan',
          'Tidak dapat mengirim tiket. Pengendali dasbor tidak ditemukan.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Kesalahan',
        'Mohon isi semua kolom yang wajib diisi.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _clearForm() {
    selectedDepartment.value = null;
    selectedCategory.value = null;
    selectedSubCategory.value = null;
    selectedSource.value = null;
    subjectController.clear();
    descriptionController.clear();
    selectedFiles.clear();
  }

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
