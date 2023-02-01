import 'package:flutter/material.dart';
import 'package:medical_pdf/colors_constant.dart';

class DMCAPolicy extends StatefulWidget {
  @override
  _DMCAPolicyState createState() => _DMCAPolicyState();
}

class _DMCAPolicyState extends State<DMCAPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DMCA Policy", style: TextStyle(color: kTextColor)),
          backgroundColor: kMainColor,
          iconTheme: IconThemeData(color: kTextColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Text("DMCA policy"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("This Digital Millennium Copyright Act policy (\"Policy\") applies to the \"Medic E-Library\" mobile application (\"Mobile Application\" or \"Service\") and any of its related products and services (collectively, \"Services\") and outlines how this Mobile Application developer (\"Operator\", \"we\", \"us\" or \"our\") addresses copyright infringement notifications and how you (\"you\" or \"your\") may submit a copyright infringement complaint.\n\n"
                  "Protection of intellectual property is of utmost importance to us and we ask our users and their authorized agents to do the same. It is our policy to expeditiously respond to clear notifications of alleged copyright infringement that comply with the United States Digital Millennium Copyright Act (\"DMCA\") of 1998, the text of which can be found at the U.S. Copyright Office website.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("What to consider before submitting a copyright complaint"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("Before submitting a copyright complaint to us, consider whether the use could be considered fair use. Fair use states that brief excerpts of copyrighted material may, under certain circumstances, be quoted verbatim for purposes such as criticism, news reporting, teaching, and research, without the need for permission from or payment to the copyright holder.\n\n"
                  "Please note that if you are unsure whether the material you are reporting is in fact infringing, you may wish to contact an attorney before filing a notification with us.\n\n"
                  "The DMCA requires you to provide your personal information in the copyright infringement notification. If you are concerned about the privacy of your personal information, you may wish to use an agent to report infringing material for you.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("Notifications of infringement"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("If you are a copyright owner or an agent thereof, and you believe that any material available on our Services infringes your copyrights, then you may submit a written copyright infringement notification (\"Notification\") using the contact details below pursuant to the DMCA. All such Notifications must comply with the DMCA requirements. \n\n"
                  "Filing a DMCA complaint is the start of a pre-defined legal process. Your complaint will be reviewed for accuracy, validity, and completeness. If your complaint has satisfied these requirements, our response may include the removal or restriction of access to allegedly infringing material.\n\n"
                  "If we remove or restrict access to materials or terminate an account in response to a Notification of alleged infringement, we will make a good faith effort to contact the affected user with information concerning the removal or restriction of access.\n\n"
                  "Notwithstanding anything to the contrary contained in any portion of this Policy, the Operator reserves the right to take no action upon receipt of a DMCA copyright infringement notification if it fails to comply with all the requirements of the DMCA for such notifications.\n\n"
                  "The process described in this Policy does not limit our ability to pursue any other remedies we may have to address suspected infringement.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("Changes and amendments"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("We reserve the right to modify this Policy or its terms relating to the Mobile Application and Services at any time, effective upon posting of an updated version of this Policy in the Mobile Application. When we do, we will post a notification in the Mobile Application.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("Reporting copyright infringement"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("If you would like to notify us of the infringing material or activity, you may send an email to editor.woms@gmail.com.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("This document was last updated on May 14, 2021\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),

            ],
          ),
        )
    );
  }
}
