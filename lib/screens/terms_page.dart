import 'package:flutter/material.dart';
import 'package:medical_pdf/colors_constant.dart';

class TermsPage extends StatefulWidget {
  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Terms and regulation", style: TextStyle(color: kTextColor)),
          backgroundColor: kMainColor,
          iconTheme: IconThemeData(color: kTextColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              Text("Terms and Regulation"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("Welcome to App’s Terms and conditions. Please read this carefully before using our App, services, or products. This is a contract between you and App. We've also included several annotations that aren't a part of the contract itself, but are intended to emphasize key sections and help you follow the text. We've tried to be fair and straightforward. Please feel free to contact us if you have any questions or suggestions!\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),

              Text("THE AGREEMENT:"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("The use of this App and services on this App and application provided by App(hereinafter referred to as \"App\") are subject to the following Terms & Conditions, all parts and sub-parts of which are specifically incorporated by reference here. This Agreement shall govern the use of all pages on this App (hereinafter collectively referred to as \"App\") and any services provided by or on this App (\"Services\").\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),

              Text("1) DEFINITIONS"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("“Agreement” denotes to this Terms and Conditions and the Privacy Policy and other documents provided to you by the App;"
              "“We”, “us” and “our” are references to App;"
              "“User”, “You” and ““your” are denotes to the person who is accessing the App for taking or availing any service from us. User shall include the company, partnership, sole trader, person, body corporate or association taking services of this App;\n"
              "“App” shall mean and include App and any successor App of the Company or any of its affiliates;\n"
              "Parties: Collectively, the parties to this Agreement (We and You) will be referred to as Parties.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("2) ASSENT & ACCEPTANCE"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("By using the App, you warrant that you have read and reviewed this Agreement and that you agree to be bound by it. If you do not agree to be bound by this Agreement, please leave the App immediately. We only agree to provide the use of this App and Services to you if you assent to this Agreement.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("3) SERVICE"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("The Services and the Platform are only for people 13 years old and over.\n"
                  "In order for us to provide App to you, we may require virtual access to and/or use of your relevant device (e.g. mobile phone, tablet or desktop computer) that you use to access App – for example, we may need to use your device's processor and storage to complete the relevant App Software installation, or we may need to access your contact list to provide certain interactive functions within App.\n"
                  "We will provide further information regarding how App uses and accesses your device within App or in another manner (e.g. via the relevant app store as part of the installation process for App on your device). You agree to give us such access to and use of your device, and you acknowledge that if you do not provide us with such right of use or access, we may not be able to provide App (or certain features within App) to you.\n"
                  "We agree to provide you with the App Service. The Service includes all of the App products, features, applications, services, technologies, and software that we provide to advance App 's mission: To carry and bring you nearer to individuals and things you love in your life. The Service is made up of the following aspects\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	Ensuring access to our Service.\n"
                    "To operate our global Service, we must store and transfer data across our systems around the world, including outside of your country of residence. The use of this global infrastructure is necessary and essential to provide our Service. \n\n"
                    "•	Research and innovation.\n"
                    "We use the information we have to develop, test, and improve our Service and collaborate with others on research to make our Service better and contribute to the well-being of our community. This includes analyzing the data we have about our users and understanding how people use our Services, for example by conducting surveys and testing and troubleshooting new features.\n\n"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("4) GENERAL CONDITION"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	We do not guarantee the accuracy, completeness, validity, or timeliness of information listed by us or other users.\n\n"
                "•	We make material changes to these terms and conditions from time to time, we may notify you either by prominently posting a notice of such changes or via email communication.\n\n"
                "•	The App is licensed to you on a limited, non-exclusive, non-transferable, non-sublicensable basis, solely to be used in connection with the Service for your private, personal, non-commercial use, subject to all the terms and conditions of this Agreement as they apply to the Service.\n\n"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("5) LICENSE TO USE APP"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("We may provide you with certain information as a result of your use of the App or Services. Such information may include but is not limited to, documentation, data, or information developed by us, and other materials which may assist in your use of the App or Services (\"Our Materials\"). Subject to this Agreement, we grant you a non-exclusive, limited, non-transferable, and revocable license to use Our Materials solely in connection with your use of the App and Services. Our Materials may not be used for any other purpose, and this license terminates upon your cessation of use of the App or Services or at the termination of this Agreement."
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("6) USER CONTENT\n"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("Content Responsibility. "
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("The App permits you to share content, post comments, feedback, etc. but you are solely responsible for the content posted by you. You represent that you have required permission to use the content.\n\n"
                "When posting content to the App, please do not post content that:"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	contains ill-mannered, profane, abusive, racist or hateful language or expressions, text, photographs or illustrations that are pornographic or in poor taste, inflammatory attacks of a personal, racial or religious nature;\n"
                "•	is defamatory, threatening, disparaging, grossly inflammatory, false, misleading, fraudulent, inaccurate, unfair, contains gross exaggeration or unsubstantiated claims;\n"
                "•	violates the privacy rights of any third party, is unreasonably harmful or offensive to any individual or community;\n"
                  "•	discriminates on the grounds of race, religion, national origin, gender, age, marital status, sexual orientation or disability, or refers to such matters in any manner prohibited by law;\n"
                  "•	violates or inappropriately encourages the violation of any municipal, state, federal or international law, rule, regulation or ordinance;\n"
                  "•	uses or attempts to use another's account, password, service or system except as expressly permitted by the Terms of use uploads or transmits viruses or other harmful, disruptive or destructive files;\n"
                  "•	sends repeated messages related to another user and/or makes derogatory or offensive comments about another individual or repeats prior posting of the same message under multiple emails or subjects.\n"
                  "•	Any submitted content that includes, but is not limited to the following, will be refused. If repeated violations occur, we reserve the right to cancel user access to the App without advanced notice. \n"
                  "•	You Give to Us. As part of our agreement, you also give us permissions that we need to provide the Service.\n"
                  "•	We do not claim ownership of your Permissions content, but you grant us a license to use it.\n"
                  "•	Nothing is changing about your rights in your content. We do not claim ownership of your content that you post on or through the Service and you are free to share your content with anyone else, wherever you want. However, we need certain legal permissions from you (known as a “license”) to provide the Service. When you share, post, or upload content that is covered by intellectual property rights (like photos or videos) on or in connection with our Service, you hereby grant to us a non-exclusive, royalty-free, transferable, sub-licensable, worldwide license to host, use, distribute, modify, run, copy, publicly perform or display, translate, and create derivative works of your content (consistent with your privacy and application settings). This license will end when your content is deleted from our systems. You can delete content individually or all at once by deleting your account.\n\n"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("7) INTELLECTUAL PROPERTY"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("You agree that the App and all Services provided by us are the property of App, including all copyrights, trademarks, trade secrets, patents, and other intellectual property (\"Our IP\"). You agree that we own all right, title, and interest in and to the Our IP and that you will not use Our IP for any unlawful or infringing purpose. You agree not to reproduce or distribute Our IP in any way, including electronically or via registration of any new trademarks, trade names, service marks, or Uniform Resource Locators (URLs), without express written permission from us."
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	To make the App and Services available to you, you hereby grant us a royalty-free, non-exclusive, worldwide license to copy, display, use, broadcast, transmit and make derivative works of any content you publish, upload, or otherwise make available to the App (\"Your Content\"). We claim no further proprietary rights in your Content."
                  "•	If you feel that any of your intellectual property rights have been infringed or otherwise violated by the posting of information or media by another of our users, please contact us and let us know."
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("8) USER OBLIGATIONS"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("Only you have the right to access and use your account. You are responsible for ensuring that your login information remain confidential at all times. App will assume that if your login are used to access the Services, the user has the legal authority to use such login. If you become aware of unauthorized use of your login, you agree to notify APP immediately by email at App. You remain liable for any activity on your account until such time as APP has been notified and has had an opportunity to take appropriate action."
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	You hereby acknowledge and understand that each User is solely responsible for all aspects of its own day-to-day operations, including provision of products (by any method, including through delivery), service, environment, and overall quality and accuracy."
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("Compliance."
                ,style: TextStyle(color: kTextColor , fontSize: 20, fontWeight: FontWeight.w600),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	You hereby acknowledge and understand that each user is solely responsible and liable for any marketing, selling, and provision of any products or services offered to Guests through the Services in compliance with all Applicable Law and Rules. APP makes no representation or warranty regarding whether a user holds any applicable permit, license, registration, or other credential for its business; whether representations by a user are true and accurate; or whether a user complies with Applicable Law and Rules, and App is not responsible for the quality of the products or services provided by any user on the platform."
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("9)NO MALICIOUS OR ILLEGAL USE"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("Account Owner and any Authorized User shall not (and shall not allow any third party to):"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("1.	distribute viruses or other harmful or malicious computer code via or into the App;\n"
                  "2.	engage in any conduct that disrupts or impedes a third party’s use and enjoyment of the APP Services;\n"
                  "3.	use the output or other information generated by the Services for any purpose other than as contemplated by this Agreement;\n"
                  "4.	use the APP Services for any use other than Customer’s internal business use;\n"
                  "5.	use unauthorized modified versions of the Services, including without limitation, for the purpose of building a similar or competitive App or Services or for the purpose of obtaining unauthorized access to the Services;\n"
                  "6.	use the Services in any way that is contrary to applicable local, state/provincial, federal and foreign laws, including without limitation those relating to privacy, electronic communications and anti-spam legislation.\n"
                  "7.	APP retains all titles to, and, except as expressly licensed herein, all rights to the Services, all copies, derivatives and improvements thereof and all related documentation and materials.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("10) ACCEPTABLE USE"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("You agree not to use the App or Services for any unlawful purpose or any purpose prohibited under this clause. You agree not to use the App or Services in any way that could damage the App, Services, or general business of App.\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	You further agree not to use the App or Services:\n"
                    "•	To harass, abuse, or threaten others or otherwise violate any person's legal rights;\n"
                    "•	To violate any of our intellectual property rights or any third party;"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("To upload or otherwise disseminate any computer viruses or other software that may damage the property of another;\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	To perpetrate any fraud;\n"
                    "•	To engage in or create any unlawful gambling, sweepstakes, or pyramid scheme;\n"
                    "•	To publish or distribute any obscene or defamatory material;\n"
                    "•	To publish or distribute any material that incites violence, hate, or discrimination towards any group;\n"
                    "•	To unlawfully gather information about others.\n\n"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),

              Text("11) ASSUMPTION OF RISK"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("The App and Services are provided for communication purposes only. You acknowledge and agree that any information posted on Our App is not intended to be legal advice, medical advice, or financial advice, and no fiduciary relationship has been created between you and us. You further agree that your purchase of any of the product on the App is at your own risk. We do not assume responsibility or liability for any advice or other information given on the App.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("12) REVERSE ENGINEERING & SECURITY"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("You agree not to undertake any of the following actions:"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("a) Reverse engineer, or attempt to reverse engineer or disassemble any code or software from or on the App or Services;\n"
                    "b) Violate the security of the App or Services through any unauthorized access, circumvention of encryption or other security tools, data mining, or interference to any host, user or network.\n\n"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("13) INDEMNIFICATION"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("You agree to defend and indemnify us and any of our affiliates (if applicable) and hold us harmless against any legal claims and demands, including reasonable attorney's fees, which may arise from or relate to your use or misuse of the App or Services, your breach of this Agreement, or your conduct or actions. You agree that we shall be able to select its legal counsel and may participate in its defense if we wish.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("14) EXCLUSION OF LIABILITY"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("You understand and agree that we (A) do not guarantee the accuracy, completeness, validity, or timeliness of information listed by us or any third parties; and (B) shall not be responsible for any materials posted by us or any third party. You shall use your judgment, caution, and common sense in evaluating any prospective methods or offers and any information provided by us or any third party.\n\n"
                  "Further, we shall not be liable for direct, indirect consequential, or any other form of loss or damage that may be suffered by a user through the use of the AppApp including loss of data or information or any kind of financial or physical loss or damage.\n\n"
                  "In no event shall App  , nor its Owner, directors, employees, partners, agents, suppliers, or affiliates, be accountable for any indirect, incidental, special, eventful or exemplary costs, including without limitation, loss of proceeds, figures, usage, goodwill, or other intangible losses, consequential from (i) your use or access of or failure to access or use the Service; (ii) any conduct or content of any third party on the Service; (iii) any content attained from the Service; and (iv) unlawful access, use or alteration of your transmissions or content, whether or not based on guarantee, agreement, domestic wrong (including carelessness) or any other lawful concept, whether or not we've been aware of the possibility of such damage, and even if a cure set forth herein is originated to have futile of its important purpose.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("15) SPAM POLICY"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("You are strictly prohibited from using the App or any of our Services for illegal spam activities, including gathering email addresses and personal information from others or sending any mass commercial emails.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("16) THIRD-PARTY LINKS & CONTENT"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("We may occasionally post links to third-party websites or other services. You agree that we are not responsible or liable for any loss or damage caused as a result of your use of any third-party services linked to or from Our App.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("17) MODIFICATION & VARIATION"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("We may, from time to time and at any time without notice to you, modify this Agreement. You agree that we have the right to modify this Agreement or revise anything contained herein. You further agree that all modifications to this Agreement are in full force and effect immediately upon posting on the App and that modifications or variations will replace any prior version of this Agreement unless prior versions are specifically referred to or incorporated into the latest modification or variation of this Agreement.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("18) ENTIRE AGREEMENT"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("This Agreement constitutes the entire understanding between the Parties concerning any use of this App. This Agreement supersedes and replaces all prior or contemporaneous agreements or understandings, written or oral, regarding the use of this App.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("19) SERVICE INTERRUPTIONS"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("We may need to interrupt your access to the App to perform maintenance or emergency services on a scheduled or unscheduled basis. You agree that your access to the App may be affected by unanticipated or unscheduled downtime, for any reason, but that we shall have no liability for any damage or loss caused as a result of such downtime.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("20) TERM, TERMINATION & SUSPENSION"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("We may terminate this Agreement with you at any time for any reason, with or without cause. We specifically reserve the right to terminate this Agreement if you violate any of the terms outlined herein, including, but not limited to, violating the intellectual property rights of us or a third party, failing to comply with applicable laws or other legal obligations, and/or publishing or distributing illegal material. If you have registered for an account with Us, you may also terminate this Agreement at any time by contacting us and requesting termination. At the termination of this Agreement, any provisions that would be expected to survive termination by their nature shall remain in full force and effect.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	We can remove any content or information you share on the Service if we believe that it violates these Terms of Use, our policies\n"
                    "•	Content will not be deleted within 90 days of the account deletion or content deletion process beginning in the following situations:\n"
                    "•	Where your content has been used by others in accordance with this license and they have not deleted it (in which case this license will continue to apply until that content is deleted); or\n"
                    "•	Where deletion within 90 days is not possible due to technical limitations of our systems, in which case, we will complete the deletion as soon as technically feasible; or\n"
                    "•	Where deletion would restrict our ability to:\n"
                    "•	Investigate or identify illegal activity or violations of our terms and policies (for example, to identify or investigate misuse of our products or systems);\n"
                    "•	Protect the safety and security of our products, systems, and users;\n"
                    "•	Comply with a legal obligation, such as the preservation of evidence; or\n"
                    "•	Comply with a request of a judicial or administrative authority, law enforcement or a government agency;\n"
                    "•	In which case, the content will be retained for no longer than is necessary for the purposes for which it has been retained (the exact duration will vary on a case-by-case basis).\n"
                    "•	If you delete or we disable your account, these terms shall terminate as an agreement between you and us, but this section and the section below called \"our agreement and what happens if we disagree\" will still apply even after your account is terminated, disabled, or deleted.\n\n"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("21) NO WARRANTIES"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("You agree that your use of the App and Services is at your sole and exclusive risk and that any Services provided by us are on an \"As Is\" basis. We hereby expressly disclaim any express or implied warranties of any kind, including, but not limited to the implied warranty of fitness for a particular purpose and the implied warranty of merchantability. We make no warranties that the App or Services will meet your needs or that the App or Services will be uninterrupted, error-free, or secure. We also make no warranties as to the reliability or accuracy of any information on the App or obtained through the Services. You agree that any damage that may occur to you, through your computer system, or as a result of the loss of your data from your use of the App or Services is your sole responsibility and that we are not liable for any such damage or loss.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("22) LIMITATION ON LIABILITY"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("We are not liable for any damages that may occur to you as a result of your use of the App or Services, to the fullest extent permitted by law. This section applies to any claims by you, including, but not limited to, lost profits or revenues, consequential or punitive damages, negligence, strict liability, fraud, or torts of any kind.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              Text("23) DISCLAIMER"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("•	You are responsible for your own health App is not a medical service and is not to be used for the purpose of seeking, and APP not providing, medical treatment or advice. Information made available through the Services and by our partners and affiliates shall solely be used for recreational and educational purposes.\n"
                    "•	You use the Service at your own risk. The Service is provided “AS IS”, without any warranties, and App does not warrant that the Service and availability thereof will be uninterrupted or error-free. APP does not assume any responsibility for errors or omissions in the information or software or other documents, including User Content, which are referenced by or linked to. References or links to third parties’ App/APP s are provided “AS IS” without warranty of any kind, either express or implied.\n"
                    "•	APP cannot guarantee that the information provided in our database is accurate, reliant or complete. App is not responsible for any personal injury or any other damages that may have been the result, direct or indirect, of any use or misuse of the Services.\n"
                    "•	Our APP or Services may be temporarily unavailable from time to time for maintenance or other reasons App assumes no responsibility for any error, omission, interruption, deletion, defect, delay in operation or transmission, communications line failure, theft or destruction or unauthorized access to, or alteration of, User communications.\n"
                    "•	Under no circumstances will App. be responsible for any loss or damage, including any loss or damage or personal injury or death, resulting from anyone’s use of our APP or Services, or any interactions between Users or Coach of our APP or Services, whether online or offline App reserves the right to change any Content, video and other items used or contained in our APP or Services, at any time without notice. Reference to any products, services, processes or other information, by trade name, trademark, manufacturer, supplier or otherwise does not constitute or imply endorsement, sponsorship or recommendation thereof, or any affiliation therewith, by our App/APP, by third parties or by any of the equipment or programming associated with or utilized by our Services.\n"
                    "•	In no event shall App or its affiliates, officers and/or employees be liable with respect to APP for (i) in the aggregate, any amount in excess of the fees paid by you to subscribe to App (ii) lost profits, lost data, o failure to meet any duty including without limitation good faith and reasonable care arising out of your access to or use App; or (iii) any direct, indirect, incidental, punitive, special, exemplary, or consequential damages of any kind whatsoever.\n"
                    "•	You agree that this limitation of liability is a reasonable allocation of risk and is a fundamental element of the basis of the bargain between App and you. You understand that App would not be provided without such limitations. Some jurisdictions do not allow the limitations in this section, so they may not apply to you.\n"
                    "•	Without limiting the foregoing, you understand and agree that you download or otherwise obtain content and related content from or through our APP or services at your own risk and that you will be solely responsible for your use thereof and any damages to your mobile device or computer system, loss of data or other harm of any kind that may result. we, as well as all of our affiliates, are not liable for any indirect, special, incidental or consequential damages (including damages for loss of business, loss of profits, litigation, or the like), whether based on breach of contract, breach of warranty, tort (including negligence), product liability or otherwise, even if advised of the possibility of such damages. the negation and limitation of damages set forth above are fundamental elements of the basis of the bargain between you and App.\n"
                    "•	Our APP and services would not be provided without such limitations. no advice or information, whether oral or written, obtained by you from us through our APP or services shall create any warranty, representation or guarantee not expressly stated in this agreement.\n"
                    "•	If you have any specific questions about any medical matter, you should consult your doctor or other professional healthcare provider.\n"
                    "•	If you think you may be suffering from any medical condition you should seek immediate medical attention from Doctor or Physician.\n"
                    "•	The Content on this APP is provided for informational purposes only and is not intended to be a substitute for professional or safety advice. At any time, you have questions regarding a specific situation, you should seek the advice of a professional.\n\n"
                  ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),
              ),
              Text("24) GENERAL PROVISIONS:"
                ,style: TextStyle(color: kTextColor , fontSize: 22, fontWeight: FontWeight.w600),),
              Text("1.	JURISDICTION, VENUE & CHOICE OF LAW: The terms herein will be governed by and construed in accordance with the laws of Nepal without giving effect to any principles of conflicts of law. The Courts of Nepal shall have exclusive jurisdiction over any dispute arising from the use of the Website.\n"
                  "2.	ASSIGNMENT: This Agreement, or the rights granted hereunder, may not be assigned, sold, leased, or otherwise transferred in whole or part by you. Should this Agreement, or the rights granted hereunder, by assigned, sold, leased, or otherwise transferred by us, the rights and liabilities of App will bind and inure to any assignees, administrators, successors, and executors.\n"
                  "3.	SEVERABILITY: If any part or sub-part of this Agreement is held invalid or unenforceable by a court of law or competent arbitrator, the remaining parts and sub-parts will be enforced to the maximum extent possible. In such a condition, the remainder of this Agreement shall continue in full force.\n"
                  "4.	SUSPENSION AND TERMINATION We may suspend or terminate your user account or temporarily disable access to whole or part of any Service in the event of any suspected illegal activity, extended periods of inactivity or requests by law enforcement or other government agencies. Objections to suspension or disabling of user accounts should be made at App within thirty days of being notified about the suspension.\n"
                  "5.	NO WAIVER: If we fail to enforce any provision of this Agreement, this shall not constitute a waiver of any future enforcement of that provision or any other provision. Waiver of any part or sub-part of this Agreement will not constitute a waiver of any other part or sub-part.\n"
                  "6.	CONFIDENTIALITY You shall agree and acknowledge that you may have access to certain information and materials, including the terms of the Agreement, concerning the business, clients, business writings, employee’s information, business technologies that we use, products and services of the other party, that are business secrets and confidential information. You shall note except with your prior permission, replicate, reproduce, use, share, and disclose to any other third-party any Confidential Information or business secrets. You shall return to us or destroy the business secrets or Confidential Information promptly upon our written request.\n"
                  "7.	HEADINGS FOR CONVENIENCE ONLY: Headings of parts and sub-parts under this Agreement are for convenience and organization, only. Headings shall not affect the meaning of any provisions of this Agreement.\n"
                  "8.	NO AGENCY, PARTNERSHIP OR JOINT VENTURE: No agency, partnership, or joint venture has been created between the Parties as a result of this Agreement. No Party has any authority to bind the other to third parties.\n"
                  "9.	FORCE MAJEURE: We are not liable for any failure to perform due to causes beyond its reasonable control including, but not limited to, acts of God, acts of civil authorities, acts of military authorities, riots, embargoes, acts of nature and natural disasters, and other acts which may be due to unforeseen circumstances, i.e. COVID-19!\n"
                  "10.	ELECTRONIC COMMUNICATIONS PERMITTED: Electronic communications are permitted to both Parties under this Agreement, including e-mail. For any questions or concerns, please use contact us form on the website or email us \n"
                  "1.	END OF TERMS OF SERVICE : If you have any questions or concerns regarding this Agreement, please contact us.\n\n"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),

              Text("This Document is last updated on May 14, 2021"
                ,style: TextStyle(color: kTextColor , fontSize: 18, fontWeight: FontWeight.w100),),


            ],
          ),
        )
    );
  }
}
