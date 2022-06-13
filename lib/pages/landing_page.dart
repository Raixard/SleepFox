import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepfox/pages/registration_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff0f8ea),
        body: ListView(
          padding: const EdgeInsets.all(17),
          children: [
            const SizedBox(
              height: 90,
            ),
            const Text(
              "Antrian Dokter Praktek",
              style: TextStyle(
                  fontFamily: "PoppinsBold",
                  fontSize: 24,
                  color: Color(0xff333333)),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    fontSize: 13,
                    color: Color(0xff333333)),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "Booking antrian sekarang lebih mudah melalui handphone."),
                  TextSpan(
                      text:
                          " Antri sekarang dan datang saat nomor sudah dekat."),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 21,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                    onPressed: () {
                      Get.off(RegistrationPage());
                    },
                    style: ElevatedButton.styleFrom(
                        maximumSize: const Size(171, 47),
                        minimumSize: const Size(171, 47),
                        primary: const Color(0xfff0f66e),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: const Text(
                      "Meditasi Sekarang",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 13,
                      ),
                    ))),
            const SizedBox(height: 21),
            Container(
              alignment: Alignment.topRight,
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: Image.asset("assets/medical_staff.png"),
            )
          ],
        ));
  }
}
