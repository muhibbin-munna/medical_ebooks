import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:medical_pdf/colors_constant.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:path_provider/path_provider.dart';

class ECG extends StatefulWidget {
  @override
  _ECGState createState() => _ECGState();
}

class _ECGState extends State<ECG> {
  List title = [
    'Sinus rhythm with ventricular extrasystoles',
    'Old inferior myocardial infraction',
    'Complete (third degree) heart block',
    'Acute anterior myocardial infarction',
    'Atrial fibrillation with digoxin effect',
    'Junctional (atrioventricular nodal re-entry) tachycardia',
    'Anterolateral ischemia',
    'Severe right ventricular hypertrophy',
    'Sinus rhythm with atrial extrasystoles',
    'Second degree (2:1) heart block',
    'Atrial flutter with 2:1 block',
    'Acute inferior myocardial infarction',
    'Wolff-Parkinson-White syndrome type A',
    'Sinus rhythm with first degree block',
    'Acute anterolateral myocardial infarction',
    'Left ventricular hypertrophy',
    'Sinus rhythm with left bundle branch block',
    'Normal ECG with sinus arrhythmia',
    'Ventricular tachycardia',
    'sinus tachycardia',
  ];

  List links = [
    '1fve7vQIZKT1G56RFh1n1jdl30ek2YNNn',
    '1_1YM1ej7BMjo3pipzAKiKGsyHhQdx4Tw',
    '1tqdwS08Lrl0Vx09ExXMlkvhCmP8w7guK',
    '1IiuvgneJrl5gsOjkd5VtqAMor0XjyOEj',
    '1g1kFmcYhCYT2O2a90TBq6urVBuPYkq8s',
    '13vq1r6GwVZqOb9m71xWUxCWt4bPorTVr',
    '1sjT06KyIDzvGXtO0502Aa6kRrMUtcUGt',
    '1rF_bnbxlZvEUioiieQzZLVKBarqu_Mnm',
    '1kxX7wRB6432R91RxVhwmXhsAAIRhHmIb',
    '1UXLymPK4FMnd_aOmyyviAy-Ujqy4_oQc',
    '1h5z-TfWJ6JDFe3Twa28ynIpszi-IzAvk',
    '1FYOzPIDh6sVFXWDctr8siZ0ZrkE9n_WP',
    '1Pb077vLKccC8SxcU4Yy0HKF55dxPkmnV',
    '1Vn8ycfYAjw2JCdfrplPMJJaExs1i_eOp',
    '1GrKZs_wHdz35DZsRGAyKpJChdroifELA',
    '14rSuky5KEfHklEar4fKR9PtissJvWdKR',
    '1GHfo7iA9qoTFSN1DC52HPgofwAfQ6bko',
    '1ndIwaxzi5S5wsBfc4b6cULK191VozbVa',
    '1H16fJPIWPSSSTPbS7tynuEvSUys4Obfb',
    '1OdFroaiYrcJrKbdAodY8_OpLk0eETuz5',
  ];

   Future<bool> checkFile(int i) async {
    try{
      final internalDir = await getApplicationDocumentsDirectory();
      String dir = internalDir.path + Platform.pathSeparator + 'download'+Platform.pathSeparator+ 'ecg'+i.toString();

      if (await File(dir).exists()) {
        print("File exists");
        return false;
      } else {
        print("File don't exists");
        return false;
      }

    }
    catch(e){
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text("Electrocardiogram (ECG)",
              style: TextStyle(color: kTextColor)),
        ),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < title.length; i++)

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeuomorphicContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
                      child: FittedBox(
                        child: Text(title[i],
                            style: TextStyle(color: kTextColor, fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FadeInImage(
                        fadeInDuration: Duration(milliseconds: 10),
                        fadeOutDuration: Duration(milliseconds: 10),
                        image: NetworkImage(
                            'https://drive.google.com/uc?export=view&id='+links[i]),
                        placeholder: AssetImage('assets/ecg_ph.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],

                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                bgColor: Color(0xBAFFB5B5),
                style: NeuomorphicStyle.Concave,
                intensity: 0.2,
                offset: Offset(8, 8),
                blur: 7,
              ),
            )

        ],
      ),
    );
  }
}
