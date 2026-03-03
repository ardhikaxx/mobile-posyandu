import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_posyandu/model/user.dart';
import 'package:mobile_posyandu/controller/jadwal_controller.dart';
import 'package:mobile_posyandu/controller/imunisasi_controller.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_posyandu/controller/auth_controller.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class DashboardPage extends StatefulWidget {
  final UserData userData;

  const DashboardPage({super.key, required this.userData});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late UserData userData;
  bool _isLoading = true;
  List<dynamic> jadwalPosyandu = [];
  List<dynamic> dataAnak = [];
  final PageController _pageController = PageController(viewportFraction: 0.8);

  final Color _primaryColor = const Color(0xFF006BFA);
  final Color _secondaryColor = const Color(0xFF4CD964);
  final Color _backgroundColor = const Color(0xFFF8FAFC);
  final Color _cardColor = Colors.white;
  final Color _textPrimary = const Color(0xFF1A1D26);
  final Color _textSecondary = const Color(0xFF6E7680);

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    userData = widget.userData;
    initializeDateFormatting('id_ID', null);
    _fetchJadwalPosyandu();
    _fetchDataAnak();
  }

  void _fetchUserData() {
    AuthController.dataProfile(context)
        .then((userData) {
          if (userData != null) {
            setState(() {
              this.userData = userData;
            });
          }
        })
        .catchError((error) {
          print('Error fetching user data: $error');
        });
  }

  Future<void> _fetchJadwalPosyandu() async {
    final now = DateTime.now();
    final bulan = now.month;
    final tahun = now.year;
    bool dataFetched = false;

    setState(() {
      _isLoading = true;
    });

    while (!dataFetched) {
      try {
        final data = await JadwalPosyanduController.fetchJadwalPosyandu(
          bulan,
          tahun,
        );
        setState(() {
          jadwalPosyandu = data;
          _isLoading = false;
        });
        dataFetched = true;
      } catch (e) {
        print('Error fetching jadwal: $e');
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Future<void> _fetchDataAnak() async {
    bool dataFetched = false;

    while (!dataFetched) {
      try {
        await ImunisasiController.fetchDataImunisasi(context);
        setState(() {
          dataAnak = ImunisasiController.imunisasiData;
        });
        dataFetched = true;
      } catch (e) {
        print('Error fetching data anak: $e');
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Widget _buildArrowIconWithBackground(
    double previousValue,
    double currentValue,
    String type,
  ) {
    IconData icon;
    Color iconColor;
    Color backgroundColor;
    String trendText;

    if (currentValue > previousValue) {
      icon = FontAwesomeIcons.arrowTrendUp;
      iconColor = _secondaryColor;
      backgroundColor = _secondaryColor.withOpacity(0.1);
      trendText = 'Naik';
    } else if (currentValue < previousValue) {
      icon = FontAwesomeIcons.arrowTrendDown;
      iconColor = Colors.red.shade400;
      backgroundColor = Colors.red.shade50;
      trendText = 'Turun';
    } else {
      icon = FontAwesomeIcons.minus;
      iconColor = _textSecondary;
      backgroundColor = _textSecondary.withOpacity(0.1);
      trendText = 'Stabil';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, color: iconColor, size: 10),
          const SizedBox(width: 2),
          Text(
            trendText,
            style: TextStyle(
              color: iconColor,
              fontSize: 8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  double _parseToDouble(dynamic value) {
    try {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    } catch (e) {
      print('Error parsing to double: $e, value: $value');
      return 0.0;
    }
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
      return formatter.format(parsedDate);
    } catch (e) {
      print('Error formatting date: $e');
      return date;
    }
  }

  String _getAnakKe(dynamic value) {
    try {
      if (value == null) return '-';
      if (value is int) return value.toString();
      if (value is String) return value;
      if (value is double) return value.toInt().toString();
      return value.toString();
    } catch (e) {
      return '-';
    }
  }

  String _getNamaAnak(dynamic value) {
    try {
      if (value == null) return 'Tidak ada nama';
      if (value is String) return value;
      return value.toString();
    } catch (e) {
      return 'Tidak ada nama';
    }
  }

  String _getJenisKelamin(dynamic value) {
    try {
      if (value == null) return 'Perempuan';
      if (value is String) return value;
      return value.toString();
    } catch (e) {
      return 'Perempuan';
    }
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 24, right: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_primaryColor, _primaryColor.withOpacity(0.9)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    FontAwesomeIcons.personBreastfeeding,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userData.namaIbu,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, _primaryColor.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jadwal Posyandu',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Bulan Ini',
                      style: TextStyle(color: _textSecondary, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _isLoading
              ? _buildSkeletonLoader()
              : jadwalPosyandu.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: jadwalPosyandu.map((jadwal) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _primaryColor.withOpacity(0.1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _primaryColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatDate(
                                    jadwal['jadwal_posyandu']?.toString() ?? '',
                                  ),
                                  style: TextStyle(
                                    color: _textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: _textSecondary,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${jadwal['jadwal_buka']?.toString() ?? '-'} - ${jadwal['jadwal_tutup']?.toString() ?? '-'}',
                                      style: TextStyle(
                                        color: _textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : Container(
                  padding: const EdgeInsets.all(20),
                  width: 350,
                  decoration: BoxDecoration(
                    color: _textSecondary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: _textSecondary,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tidak ada jadwal posyandu\nuntuk bulan ini',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return SkeletonLoader(
      builder: Column(
        children: List.generate(1, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(width: 4, height: 40, color: Colors.grey.shade300),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 120,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      items: 1,
      period: const Duration(milliseconds: 1200),
      highlightColor: Colors.grey.shade100,
      baseColor: Colors.grey.shade300,
    );
  }

  Widget _buildDataAnakSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Data Anak',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '${dataAnak.length} Anak',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          dataAnak.isNotEmpty
              ? SizedBox(
                  height: 200,
                  width: 500,
                  child: Swiper(
                    itemCount: dataAnak.length,
                    itemBuilder: (BuildContext context, int index) {
                      var anak = dataAnak[index];
                      var posyanduData = anak['posyandu'] ?? [];
                      Color backgroundColor;
                      Color accentColor;
                      if (_getJenisKelamin(anak['jenis_kelamin_anak']) ==
                          'Laki-laki') {
                        backgroundColor = const Color(0xFFE3F2FD);
                        accentColor = const Color(0xFF1976D2);
                      } else {
                        backgroundColor = const Color(0xFFFCE4EC);
                        accentColor = const Color(0xFFC2185B);
                      }

                      // Parse height data
                      double previousHeight = 0.0;
                      double currentHeight = 0.0;

                      if (posyanduData.length > 1) {
                        previousHeight = _parseToDouble(
                          posyanduData[posyanduData.length - 2]['tb_anak'],
                        );
                        currentHeight = _parseToDouble(
                          posyanduData.last['tb_anak'],
                        );
                      } else if (posyanduData.isNotEmpty) {
                        currentHeight = _parseToDouble(
                          posyanduData.last['tb_anak'],
                        );
                      }

                      // Parse weight data
                      double previousWeight = 0.0;
                      double currentWeight = 0.0;

                      if (posyanduData.length > 1) {
                        previousWeight = _parseToDouble(
                          posyanduData[posyanduData.length - 2]['bb_anak'],
                        );
                        currentWeight = _parseToDouble(
                          posyanduData.last['bb_anak'],
                        );
                      } else if (posyanduData.isNotEmpty) {
                        currentWeight = _parseToDouble(
                          posyanduData.last['bb_anak'],
                        );
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(40),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            _getJenisKelamin(
                                                      anak['jenis_kelamin_anak'],
                                                    ) ==
                                                    'Laki-laki'
                                                ? FontAwesomeIcons.child
                                                : FontAwesomeIcons.childDress,
                                            color: accentColor,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _getNamaAnak(anak['nama_anak']),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: _textPrimary,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Anak ke-${_getAnakKe(anak['anak_ke'])}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: _textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  if (posyanduData.isNotEmpty)
                                    _buildDataRowHorizontal(
                                      currentWeight,
                                      previousWeight,
                                      currentHeight,
                                      previousHeight,
                                      accentColor,
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: accentColor,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'Data perkembangan belum tersedia',
                                              style: TextStyle(
                                                color: _textSecondary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemWidth: 600,
                    itemHeight: 300,
                    layout: SwiperLayout.TINDER,
                  ),
                )
              : Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: _textSecondary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.child_care_outlined,
                          size: 50,
                          color: _textSecondary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Belum ada data anak',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Data anak akan muncul di sini',
                          style: TextStyle(
                            fontSize: 14,
                            color: _textSecondary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildDataRowHorizontal(
    double currentWeight,
    double previousWeight,
    double currentHeight,
    double previousHeight,
    Color accentColor,
  ) {
    return Row(
      children: [
        // Berat Badan - Kiri
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.monitor_weight_outlined,
                      color: accentColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Berat Badan',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${currentWeight.toStringAsFixed(1)} kg',
                      style: TextStyle(
                        fontSize: 16,
                        color: _textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (previousWeight > 0)
                      _buildArrowIconWithBackground(
                        previousWeight,
                        currentWeight,
                        'bb',
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Tinggi Badan - Kanan
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.height_outlined, color: accentColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Tinggi Badan',
                      style: TextStyle(
                        fontSize: 12,
                        color: _textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${currentHeight.toStringAsFixed(1)} cm',
                      style: TextStyle(
                        fontSize: 16,
                        color: _textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (previousHeight > 0)
                      _buildArrowIconWithBackground(
                        previousHeight,
                        currentHeight,
                        'tb',
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _buildJadwalCard(),
                    const SizedBox(height: 16),
                    _buildDataAnakSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
