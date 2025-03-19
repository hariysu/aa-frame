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
  SinirDegerlerResponse? _originalData;
  bool _isComparisonModeEnabled = false;
  double _modificationFactor = 1.0;

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
        _originalData = data;
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

  void _applyModificationFactor() {
    if (_originalData == null) return;

    setState(() {
      // Using freezed's copyWith to create a modified copy of the data
      _data = _originalData!.copyWith(
        esikDegerMadde13Alt:
            (_originalData!.esikDegerMadde13Alt * _modificationFactor).round(),
        esikDegerMadde13Orta:
            (_originalData!.esikDegerMadde13Orta * _modificationFactor).round(),
        esikDegerMadde13Ust:
            (_originalData!.esikDegerMadde13Ust * _modificationFactor).round(),
        esikDegerMadde8GenelButceMalHizmet:
            (_originalData!.esikDegerMadde8GenelButceMalHizmet *
                    _modificationFactor)
                .round(),
        esikDegerMadde8KITMalHizmet:
            (_originalData!.esikDegerMadde8KITMalHizmet * _modificationFactor)
                .round(),
        esikDegerMadde8Yapim:
            (_originalData!.esikDegerMadde8Yapim * _modificationFactor).round(),
        sikayet1: (_originalData!.sikayet1 * _modificationFactor).round(),
        sikayet1Bedel:
            (_originalData!.sikayet1Bedel * _modificationFactor).round(),
        sikayet2: (_originalData!.sikayet2 * _modificationFactor).round(),
        sikayet2Bedel:
            (_originalData!.sikayet2Bedel * _modificationFactor).round(),
        sikayet3: (_originalData!.sikayet3 * _modificationFactor).round(),
        sikayet3Bedel:
            (_originalData!.sikayet3Bedel * _modificationFactor).round(),
        sikayet4Bedel:
            (_originalData!.sikayet4Bedel * _modificationFactor).round(),
      );
    });
  }

  void _resetData() {
    setState(() {
      _data = _originalData;
      _modificationFactor = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sınır Değerler'),
        actions: [
          if (_data != null)
            IconButton(
              icon: Icon(_isComparisonModeEnabled
                  ? Icons.compare_arrows
                  : Icons.compare),
              onPressed: () {
                setState(() {
                  _isComparisonModeEnabled = !_isComparisonModeEnabled;
                });
              },
              tooltip: 'Karşılaştırma Modu',
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: Column(
          children: [
            if (_data != null && !_isLoading)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Değer Düzenleme Çarpanı: ${_modificationFactor.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _modificationFactor,
                      min: 0.5,
                      max: 2.0,
                      divisions: 30,
                      label: _modificationFactor.toStringAsFixed(2),
                      onChanged: (value) {
                        setState(() {
                          _modificationFactor = value;
                        });
                      },
                      onChangeEnd: (value) {
                        _applyModificationFactor();
                      },
                    ),
                    ElevatedButton(
                      onPressed: _resetData,
                      child: const Text('Orijinal Değerlere Sıfırla'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
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
          _buildInfoCardWithComparison('Madde 13 Alt',
              _data!.esikDegerMadde13Alt, _originalData?.esikDegerMadde13Alt),
          _buildInfoCardWithComparison('Madde 13 Orta',
              _data!.esikDegerMadde13Orta, _originalData?.esikDegerMadde13Orta),
          _buildInfoCardWithComparison('Madde 13 Üst',
              _data!.esikDegerMadde13Ust, _originalData?.esikDegerMadde13Ust),
          _buildInfoCardWithComparison(
              'Madde 8 Genel Bütçe Mal Hizmet',
              _data!.esikDegerMadde8GenelButceMalHizmet,
              _originalData?.esikDegerMadde8GenelButceMalHizmet),
          _buildInfoCardWithComparison(
              'Madde 8 KIT Mal Hizmet',
              _data!.esikDegerMadde8KITMalHizmet,
              _originalData?.esikDegerMadde8KITMalHizmet),
          _buildInfoCardWithComparison('Madde 8 Yapım',
              _data!.esikDegerMadde8Yapim, _originalData?.esikDegerMadde8Yapim),
          const SizedBox(height: 24),
          _buildSectionTitle('Şikayet Değerleri'),
          _buildInfoCardWithComparison(
              'Şikayet 1', _data!.sikayet1, _originalData?.sikayet1),
          _buildInfoCardWithComparison('Şikayet 1 Bedel', _data!.sikayet1Bedel,
              _originalData?.sikayet1Bedel),
          _buildInfoCardWithComparison(
              'Şikayet 2', _data!.sikayet2, _originalData?.sikayet2),
          _buildInfoCardWithComparison('Şikayet 2 Bedel', _data!.sikayet2Bedel,
              _originalData?.sikayet2Bedel),
          _buildInfoCardWithComparison(
              'Şikayet 3', _data!.sikayet3, _originalData?.sikayet3),
          _buildInfoCardWithComparison('Şikayet 3 Bedel', _data!.sikayet3Bedel,
              _originalData?.sikayet3Bedel),
          _buildInfoCardWithComparison('Şikayet 4 Bedel', _data!.sikayet4Bedel,
              _originalData?.sikayet4Bedel),
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

  Widget _buildInfoCardWithComparison(
      String title, int value, int? originalValue) {
    final formattedValue = _formatCurrency(value);
    final showComparison = _isComparisonModeEnabled &&
        originalValue != null &&
        value != originalValue;

    final percentChange = originalValue != null && originalValue != 0
        ? ((value - originalValue) / originalValue * 100)
        : 0.0;

    final isIncrease = percentChange > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                  formattedValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (showComparison) ...[
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Orijinal Değer:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    _formatCurrency(originalValue),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Değişim:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 14,
                        color: isIncrease ? Colors.green : Colors.red,
                      ),
                      Text(
                        '%${percentChange.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isIncrease ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
