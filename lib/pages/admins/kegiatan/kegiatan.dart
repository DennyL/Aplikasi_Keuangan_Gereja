//ignore_for_file: todo, prefer_const_constructors
import 'package:aplikasi_keuangan_gereja/services/apiservices.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../themes/colors.dart';
import '../../../widgets/loadingindicator.dart';
import '../../../widgets/responsivetext.dart';

class AdminControllerKegiatanPage extends StatefulWidget {
  const AdminControllerKegiatanPage({Key? key}) : super(key: key);

  @override
  State<AdminControllerKegiatanPage> createState() =>
      _AdminControllerKegiatanPageState();
}

class _AdminControllerKegiatanPageState
    extends State<AdminControllerKegiatanPage> {
  final _controllerPageKegiatan = PageController();
  final _controllerDetailPageKegiatan = PageController();
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerPageKegiatan.dispose();
    _controllerDetailPageKegiatan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controllerPageKegiatan,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        PageView(
          controller: _controllerDetailPageKegiatan,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AdminKegiatanPage(
              controllerPageKegiatan: _controllerPageKegiatan,
              controllerDetailPageKegiatan: _controllerDetailPageKegiatan,
            ),
            DetailKebutuhanPage(
              controllerDetailPageKegiatan: _controllerDetailPageKegiatan,
            ),
          ],
        ),
        BuatKegiatanPage(controllerPageKegiatan: _controllerPageKegiatan),
      ],
    );
  }
}

class AdminKegiatanPage extends StatefulWidget {
  final PageController controllerPageKegiatan;
  final PageController controllerDetailPageKegiatan;
  const AdminKegiatanPage(
      {Key? key,
      required this.controllerPageKegiatan,
      required this.controllerDetailPageKegiatan})
      : super(key: key);

  @override
  State<AdminKegiatanPage> createState() => _AdminKegiatanPageState();
}

class _AdminKegiatanPageState extends State<AdminKegiatanPage> {
  ServicesUser servicesUser = ServicesUser();
  late Future kategoriProposalKegiatan;

  @override
  void initState() {
    // TODO: implement initState
    kategoriProposalKegiatan = servicesUser.getAllProposalKegiatan("gms001");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          controller: ScrollController(),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              width: deviceWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      responsiveText("Kegiatan", 36, FontWeight.w900, darkText),
                      SizedBox(
                        width: 25,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.history_rounded),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color(0xFFf9ab27),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            onPressed: () {
                              widget.controllerPageKegiatan.animateToPage(1,
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.ease);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add_circle_outline_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Buat Data Kegiatan',
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: navButtonPrimary.withOpacity(0.4),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FutureBuilder(
                        future: kategoriProposalKegiatan,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List snapData = snapshot.data! as List;
                            if (snapData[0] != 404) {
                              return ScrollConfiguration(
                                behavior:
                                    ScrollConfiguration.of(context).copyWith(
                                  dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  },
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  controller: ScrollController(),
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: snapData[1].length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color:
                                              navButtonPrimary.withOpacity(0.4),
                                        ),
                                      ),
                                      color: scaffoldBackgroundColor,
                                      child: ListTile(
                                        leading: Text(
                                          snapData[1][index]['nama_kegiatan'],
                                        ),
                                        trailing: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(12),
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () {
                                            widget.controllerDetailPageKegiatan
                                                .animateToPage(1,
                                                    duration: const Duration(
                                                        milliseconds: 250),
                                                    curve: Curves.ease);
                                          },
                                          child: const Icon(
                                              Icons.arrow_forward_rounded),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                          return loadingIndicator(primaryColorVariant);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: Buat Kegiatan Page
class BuatKegiatanPage extends StatefulWidget {
  final PageController controllerPageKegiatan;
  const BuatKegiatanPage({Key? key, required this.controllerPageKegiatan})
      : super(key: key);

  @override
  State<BuatKegiatanPage> createState() => _BuatKegiatanPageState();
}

class _BuatKegiatanPageState extends State<BuatKegiatanPage> {
  final _controllerKodeKegiatan = TextEditingController();
  final _controllerNamaKegiatan = TextEditingController();
  final _controllerjawab1 = TextEditingController();
  final _controllerjawab2 = TextEditingController();
  final _controllerJenisKebutuhan = TextEditingController();
  final _controllerSaldo = TextEditingController();
  final _controllerKeterangan = TextEditingController();

  ServicesUser servicesUserItem = ServicesUser();
  late Future kategoriItemProposalKegiatan;

  @override
  void initState() {
    // TODO: implement initState
    kategoriItemProposalKegiatan =
        servicesUserItem.getAllItemProposalKegiatan("dns007");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  responsiveTextField(deviceWidth, deviceHeight, controllerText) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: deviceWidth * 0.5,
        child: TextField(
          controller: controllerText,
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: surfaceColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showTambahDialogKebutuhan(dw, dh) {
    showDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: ScrollController(),
                  child: SizedBox(
                    width: dw * 0.5,
                    child: Column(
                      children: [
                        Container(
                          width: dw * 0.5,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              responsiveText("Tambah Kebutuhan", 26,
                                  FontWeight.w700, darkText),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  responsiveText("Jenis Kebutuhan", 16,
                                      FontWeight.w700, darkText),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  responsiveTextField(
                                      dw, dh, _controllerJenisKebutuhan),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  responsiveText(
                                      "Saldo", 16, FontWeight.w700, darkText),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  responsiveTextField(dw, dh, _controllerSaldo),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (mounted) {
                                    setState(() {});
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text("Batal"),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (mounted) {
                                    setState(() {});
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text("Tambah"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          right: 30,
          bottom: 30,
          child: Image(
            width: (MediaQuery.of(context).size.width) * 0.33,
            image: AssetImage(
              'lib/assets/images/createaktifitas.png',
            ),
          ),
        ),
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: ScrollController(),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: deviceWidth,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          widget.controllerPageKegiatan.animateToPage(0,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.ease);
                        },
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Buat Kegiatan",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 56,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        responsiveText(
                            "Kode Kegiatan", 14, FontWeight.w700, darkText),
                        SizedBox(
                          height: 10,
                        ),
                        responsiveTextField(
                            deviceWidth, deviceHeight, _controllerKodeKegiatan),
                        SizedBox(
                          height: 15,
                        ),
                        responsiveText(
                            "Nama Kegiatan", 14, FontWeight.w700, darkText),
                        SizedBox(
                          height: 10,
                        ),
                        responsiveTextField(
                            deviceWidth, deviceHeight, _controllerNamaKegiatan),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                responsiveText("Penanggung Jawab 1", 14,
                                    FontWeight.w700, darkText),
                                SizedBox(
                                  height: 10,
                                ),
                                responsiveTextField(deviceWidth / 2,
                                    deviceHeight, _controllerjawab1),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                responsiveText("Penanggung Jawab 2", 14,
                                    FontWeight.w700, darkText),
                                SizedBox(
                                  height: 10,
                                ),
                                responsiveTextField(deviceWidth / 2,
                                    deviceHeight, _controllerjawab2),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: deviceWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Color(0xFFf9ab27),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  _showTambahDialogKebutuhan(
                                      deviceWidth, deviceHeight);
                                },
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: deviceWidth * 0.50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: navButtonPrimary.withOpacity(0.4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: FutureBuilder(
                                future: kategoriItemProposalKegiatan,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List snapData = snapshot.data! as List;
                                    if (snapData[0] != 404) {
                                      return ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(
                                          dragDevices: {
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.mouse,
                                          },
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          controller: ScrollController(),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: snapData[1].length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                side: BorderSide(
                                                  color: navButtonPrimary
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              color: scaffoldBackgroundColor,
                                              child: ListTile(
                                                title: Text(
                                                  snapData[1][index]
                                                      ['jenis_kebutuhan'],
                                                ),
                                                subtitle: Text(
                                                  snapData[1][index]
                                                          ['budget_kebutuhan']
                                                      .toString(),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.close)),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  }
                                  return loadingIndicator(primaryColorVariant);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width) * 0.5,
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Color(0xFFf9ab27),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  _controllerNamaKegiatan.clear();
                                  _controllerjawab1.clear();
                                  _controllerjawab2.clear();
                                  _controllerJenisKebutuhan.clear();
                                  _controllerSaldo.clear();
                                  _controllerKeterangan.clear();

                                  widget.controllerPageKegiatan.animateToPage(0,
                                      duration: Duration(milliseconds: 700),
                                      curve: Curves.easeOut);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    'Buat',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

//TODO: Detail kebutuhan page
class DetailKebutuhanPage extends StatefulWidget {
  final PageController controllerDetailPageKegiatan;
  const DetailKebutuhanPage(
      {Key? key, required this.controllerDetailPageKegiatan})
      : super(key: key);

  @override
  State<DetailKebutuhanPage> createState() => _DetailKebutuhanPageState();
}

class _DetailKebutuhanPageState extends State<DetailKebutuhanPage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          controller: ScrollController(),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              width: deviceWidth,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          widget.controllerDetailPageKegiatan.animateToPage(0,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.ease);
                        },
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Detail Kegiatan",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    height: 56,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}