import "package:flutter/material.dart";

class OtherPage extends StatelessWidget{

  final int pageTextChanged;
  OtherPage(this.pageTextChanged);
  var list = [
    "Anatomy",
    "Anesthesiology",
    "Biochemistry",
    "Community Medicine",
    "Cardiology",
    "Dermatology",
    "ECG",
    "Forensic Medicine",
    "Obstetrics and Gynaecology",
    "Orthopedics",
    "Opthalmology",
    "Microbiology",
    "Medicine",
    "Pathology",
    "Physiology",
    "Pediatrics",
    "Pharmacology",
    "Surgery"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(list[pageTextChanged]),),
      body: Center(
        child: Text(list[pageTextChanged]+ 'book list')
      ),
    );
  }


}
