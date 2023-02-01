import 'package:flutter/material.dart';
import 'package:medical_pdf/colors_constant.dart';

class Disclaimer extends StatefulWidget {
  @override
  _DisclaimerState createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disclaimer", style: TextStyle(color: kTextColor)),
        backgroundColor: kMainColor,
        iconTheme: IconThemeData(color: kTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Text("Disclaimer"
              ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
            Text("If you require any more information or have any questions about our site’s disclaimer, please feel free to contact us.\n"
              ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text("•	App makes no guarantees, representations or warranties of any kind as regards the website and associated technology. Any purportedly applicable warranties, terms and conditions are excluded, to the fullest extent permitted by law. Your use of the Service is at your sole risk. The Service is provided on an “AS IS” and “AS AVAILABLE” basis. The Service is provided without warranties of any kind.\n\n"
                  "•	You agree that from time to time we may remove the service for indefinite periods of time or cancel the service at any time, without notice to you. You expressly agree that your use of, or inability to use, the service is at your sole risk.\n\n"
                  "•	For no situation will APP, our chiefs, officials, representatives, associates, operators, contractual workers, assistants, providers, specialist co-ops or licensors be obligated for any injury, misfortune, guarantee, or any immediate, circuitous, accidental, reformatory, exceptional, or noteworthy harms of any sort, including, without restriction lost benefits, lost income, lost investment funds, loss of information, substitution costs, or any comparative harms, regardless of whether situated in contract, tort (counting carelessness), severe risk or something else, emerging from your utilization of any of the administration or any items obtained utilizing the administration, or for some other case related in any capacity to your utilization of the administration or any item, including, however not constrained to, any mistakes or oversights in any substance, or any misfortune or harm of any sort brought about because of the utilization of the administration or any substance (or item) posted, transmitted.\n\n"
                  "•	In any case made accessible by means of the administration, regardless of whether instructed concerning their chance. Since certain states or wards don’t permit the prohibition or the restriction of risk for important or accidental harms, in such states or locales, our obligation will be constrained to the greatest degree allowed by law.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
            ),
            Text("Limitation of warranties"
              ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
            Text("The information on this website is provided “as is” without any representations or warranties, express or implied APP makes no representations or warranties.Without prejudice to the generality of the foregoing paragraph APP does not warrant that:\n"
              ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text("•	The information regarding Services on this website will be constantly available, or available at all.\n\n"
              "•	The information on this website is complete regarding Different Services true, accurate, up-to-date, or non-misleading.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
            ),

            Text("Please be also aware that when you leave our website, other sites may have different privacy policies and terms which are beyond our control. Please be sure to check the Privacy Policies of these sites as well as their “Terms of Service” before engaging in any business or uploading any information.\n\n"
              ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
            Text("Consent"
              ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
            Text("By using our website, you hereby consent to our disclaimer and agree to its terms.\n\n"
              "This document was last updated on May 14, 2021"
              ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
          ],
        ),
      )
    );
  }
}
