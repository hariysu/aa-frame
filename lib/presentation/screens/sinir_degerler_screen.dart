import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/sinir_degerler_response.dart';
import '../../data/services/sinir_degerler_service.dart';

class SinirDegerlerScreen extends StatefulWidget {
  const SinirDegerlerScreen({super.key});

  @override
  State<SinirDegerlerScreen> createState() => _SinirDegerlerScreenState();
}

class _SinirDegerlerScreenState extends State<SinirDegerlerScreen> {
  final SinirDegerlerService _service = SinirDegerlerService();
  bool _isLoading = true;
  String _errorMessage = '';
  SinirDegerlerResponse? _data;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final data = await _service.fetchSinirDegerler();

      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _formatCurrency(int value) {
    final formatter = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: '₺',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sınır Değerler'),
      ),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hata: $_errorMessage',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      );
    }

    if (_data == null) {
      return const Center(
        child: Text('Veri bulunamadı'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Sonuç Bilgisi'),
          _buildResultInfo(_data!.sonuc),
          const SizedBox(height: 24),
          _buildSectionTitle('Eşik Değerleri'),
          _buildInfoCard(
              'Madde 13 Alt', _formatCurrency(_data!.esikDegerMadde13Alt)),
          _buildInfoCard(
              'Madde 13 Orta', _formatCurrency(_data!.esikDegerMadde13Orta)),
          _buildInfoCard(
              'Madde 13 Üst', _formatCurrency(_data!.esikDegerMadde13Ust)),
          _buildInfoCard('Madde 8 Genel Bütçe Mal Hizmet',
              _formatCurrency(_data!.esikDegerMadde8GenelButceMalHizmet)),
          _buildInfoCard('Madde 8 KIT Mal Hizmet',
              _formatCurrency(_data!.esikDegerMadde8KITMalHizmet)),
          _buildInfoCard(
              'Madde 8 Yapım', _formatCurrency(_data!.esikDegerMadde8Yapim)),
          const SizedBox(height: 24),
          _buildSectionTitle('Şikayet Değerleri'),
          _buildInfoCard('Şikayet 1', _formatCurrency(_data!.sikayet1)),
          _buildInfoCard(
              'Şikayet 1 Bedel', _formatCurrency(_data!.sikayet1Bedel)),
          _buildInfoCard('Şikayet 2', _formatCurrency(_data!.sikayet2)),
          _buildInfoCard(
              'Şikayet 2 Bedel', _formatCurrency(_data!.sikayet2Bedel)),
          _buildInfoCard('Şikayet 3', _formatCurrency(_data!.sikayet3)),
          _buildInfoCard(
              'Şikayet 3 Bedel', _formatCurrency(_data!.sikayet3Bedel)),
          _buildInfoCard(
              'Şikayet 4 Bedel', _formatCurrency(_data!.sikayet4Bedel)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultInfo(SonucModel sonuc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: sonuc.sonuc ? Colors.green.shade100 : Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  sonuc.sonuc ? Icons.check_circle : Icons.error,
                  color: sonuc.sonuc ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'Durum: ${sonuc.sonuc ? "Başarılı" : "Başarısız"}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: sonuc.sonuc
                        ? Colors.green.shade900
                        : Colors.red.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Mesaj: ${sonuc.mesaj}'),
            Text('Sonuç Kodu: ${sonuc.resultCode}'),
          ],
        ),
      ),
    );
  }
}
