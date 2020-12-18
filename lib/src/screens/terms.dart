import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/models/user.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    brightness: Brightness.light,
                    centerTitle: true,
                    title: Text(
                      'Legal Policy',
                      style: TextStyle(
                          fontFamily: "Ubuntu",
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(height: 10),
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15),
                            child: ListTile(
                              subtitle:   Text(
                                'By accepting the following Terms of Service (terms and conditions) for “Swift 247” (“Pickrr”), you (“The Customer”, “The Client”, “The User”) agrees to be bound by the following terms and conditions without exception.'
                                  'The Terms of Service stated herein (collectively, the “Terms of Service” or this “Agreement” or “Terms of Use”) constitute a legal agreement between you, the Rider (Delivery man/woman) and Swift 247 Limited (operating under the brand name “Pickrr”). In order to use the Service provided by Swift 247 Limited, you must agree to the Terms of Service that are set out in this Agreement. The Company reserves the right to modify, vary and change the Terms of Use or its policies relating to the Service at any time with or without prior notice. Such modifications, variations and or changes to the Terms of Service or its policies regarding the Services provided shall go into effect immediately upon update on the Swift 247 platforms you are using. You agree that it shall be your responsibility to review the Terms of Service regularly. You also agree that the continued use of the Service after any such changes, whether or not reviewed by you, shall constitute your consent and acceptance to such changes.',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: ListTile(
                              title: Text(
                              'Terms and Conditions',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6),
                              ),
                              subtitle: Text(
                                'In these Terms and Conditions where the following terminology has been used, they shall have the following meanings:\n\n'
                                  'Package: Will mean any item(s) of any sort which are or are intended to be, received by us from any one sender at an address for us to carry and deliver to any recipient at any other address.\n\n'
                            'Aged Package: Will mean a Package that is no longer in the condition in which it was received by us, or which is or becomes a health and safety risk.\n\n'
                            'Out of Gauge: Will mean a Package is outside of the weight and dimensions that we carry on a particular service. Prohibited Items: Will mean that it cannot be carried on any Service and are contrabands under the laws of the land. Purchased: Will mean when you accept the Service Order.\n\n'
                            'The Collection Point: Will mean the address at which a Package is received or collected by us.\n\n'
                            'The Delivery Point: Will mean the address to which any Package is delivered by us.\n\n'
                            'Service: Will mean the service and carriage of a Package by Rider (Delivery man/woman) in accordance with the'
                              'particulars set out in the Service Order, as per the terms and conditions.',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: ListTile(
                              title: Text(
                                'Service',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6),
                              ),
                              subtitle: Text(
                                'The Service(s) will be carried out for you whilst this Agreement is in force, in return for the payment by you to us of the price set out in the Service Order and in accordance with the terms of this Agreement.'
                                  'Swift 247 shall have the right to make any changes to the Service(s) which are necessary to comply with any applicable law or safety requirement or which do not materially affect the nature or quality of the Service(s) and any changes are not liable to be notified to you.',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: ListTile(
                              title: Text(
                                'Loading and Unloading',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6),
                              ),
                              subtitle: Text(
                               'If collection or delivery of a Package takes place at your premises, Swift 247 shall not be under any obligation to provide any equipment or labour which, apart from the Rider (Delivery man/woman) collecting the Package, may be required for loading or unloading of a Package.\n'
                                  'Any Package (or part of a Package) requiring any special equipment for loading and unloading shall be accepted by us for transportation only on the understanding and condition that such special equipment will be made available at the Collection Point and the Delivery Point as required. Where such equipment is not available and if the Rider (Delivery man/woman) agrees to load or unload the Package (or part of the Package) Swift 247 shall be under no liability or obligation of any kind to you for any damage caused (however it may be caused) during the loading or unloading of the Package.\n'
                  'This includes any damage caused whether or not by the Rider’s (Delivery man/woman’s) negligence and you shall agree to indemnify and hold us harmless against any claim or demand from any person arising out of this agreement to load or unload the Package in these circumstances.',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                            ),
                          ),
                        ),

                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: ListTile(
                              title: Text(
                                'Terms of Use of the Service',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    height: 1.6),
                              ),
                              subtitle: Text(
                               'Your Obligations\n\nYou agree to:\ni. Ensure that the information you supply in the Order Schedule is complete and accurate; cooperate with the Rider (Delivery man/woman) and Swift 247 Ltd in all matters relating to the provision of the Service(s);'
                                '\nii. Provide the Rider (Delivery man/woman) with access to your premises, office accommodation and other facilities as reasonably required, if/when any of these are to be the Collection Point or Delivery Point and be responsible for ensuring that the premises are free of hazardous materials and do not pose a health and safety risk to the Rider (Delivery man/woman).\n'
                                'iii. Provide Swift 247 Ltd with such information and materials as may be reasonably required in order to supply the Service(s) and ensure that such information is accurate in all material respects.\n'
                                'iv. You agree that the Rider (Delivery man/woman) shall not be required, and that you shall not cause them, to carry anything if it would be illegal or unlawful for them to do so under the laws of the Federal Republic of Nigeria. You agree that should you do this, you will indemnify Swift 247 Ltd against any losses and/or damage that we may suffer as a consequence.\n\n'
                                'The Rider (Delivery man/woman) shall not, carry: livestock; Food Items; liquids; perishable goods; gasses; pyrotechnics; arms; ammunition; corrosive; toxic; flammable; explosive; oxidizing or radioactive materials. In addition, the Rider (Delivery man/woman) will not carry any items which are prohibited by the laws of the Land. The Rider (Delivery man/woman) and Swift 247 Ltd reserves the right to refuse to carry any parcels which are neither the property of, nor sent on behalf of, you.\n\n'
                                'It is understood that you agree that:\n'
                                'All Packages shall be accepted at the Delivery Point and that the recipient shall give the'
                                  'Rider (Delivery man/woman) an appropriate receipt or signature and you agree that this receipt/signature shall be conclusive evidence of delivery of the Package. \nUnless specifically agreed otherwise, “working days” do not include Friday, Saturday or public holidays.'
                            'No refund or reduction shall be provided of charges if less than the number of parcels for which you have contracted has been received. That you cannot send a package weighing more than X Kilograms and that Rider (Delivery man/woman) reserves the right to refuse delivery of products weighing over the set limit.'
                          'You will be barred from sending contrabands as specified by the laws of the Land. You are liable to disclose all necessary information regarding the product to the Rider (Delivery man/woman).\n'
                          'You are to maintain extreme caution while packing the product, so as to diminish chances of damage as much as possible. You are to make sure that the items do not harm the rider in any way i.e. wrapping flowers and earrings properly.'
                        'You are encouraged to bubble-wrap any electronics you wish to transfer, so as to avoid damaging the item. You have to pay the riders upfront. Failure to do so will result in the rider cancelling your request.\n'
                        'You may not ask riders to receive cash payment from the receiver. You are to report any damaged/missing/lost items to our support team within 5 hours of dispatch. Swift 247 would not take full liability of any item that is damaged or lost.\n\n'
                                'Liability\n'
                                'YOUR ATTENTION IS DRAWN PARTICULARLY TO THIS CLAUSE AND THE LIMITS OF OUR LIABILITY WITHIN IT. As a responsible business, Swift 247 Rides Ltd and the respective Rider (Delivery man/woman) shall hopefully perform the Service(s) in a professional manner with the appropriate level of skill and care. Swift 247s will not take full liability of any item that is damaged or lost. Damage to a Package may still occur as a consequence of handling of it and in such circumstances, Swift 247 Ltd and the Rider’s (Delivery man/woman’s) liability shall be limited as set out in these Terms and Conditions.'
                                  'The reasoning behind this limitation of our liability is as follows: The value of a Package and the amount of potential loss to you that could arise if a Package is damaged or lost is not something which can be easily ascertained but is something which is better known to you.'
                              'In many cases it cannot be known to Swift 247 or the Rider (Delivery man/woman) at all and can only be known to you. The potential amount of loss that might be caused or alleged to be caused to you is likely to be disproportionate to the sum that could reasonably be expected to charge you for providing the Service(s) under this Agreement.'
                          '\nIt is not possible to obtain cover which would give unlimited compensation for full potential liability to all customers and, even if it were, such cover would be much cheaper if taken out by you and on that basis, it is more reasonable for you to take out such cover from an independent third party. It is imperative to keep the costs of providing the Service(s) to you as low as possible.'
                        'In these Terms and Conditions, damage to you means any loss of, or damage to, a Package.\n\n'
                                'Swift 247 Rides Ltd. shall not be liable to you:\n'
                                'In any circumstances in respect of the items on the Prohibited items; Special Provisions items and for damage to the No Compensation Items lists, unless otherwise stated by us. To the best of our abilities, we can connect you through to the rightful authority to investigate damage or loss of your item. However, we will not be held liable for damage of your item or loss because of the aforementioned reasons in these Terms and Conditions.\n\n'
                                'Payment:\n'
                                'You may choose to pay for the services by cash or third party payment services. Once you have used the Service, you are required to make payment in full to the Rider (Delivery man/woman) and such payment is non-refundable. If you have any complaints in relation to the transportation service provided, then contact support/customer care.\n'
                                  'You have to pay the riders upfront. Failure to do so will result in the rider cancelling your request. You may not ask riders to receive cash payment from the receiver You may purchase credits (“Swift 247 Credits”) which may be used to pay for the services. You may choose to purchase Swift 247 Credits through any of the methods as may be made available in the Application from time to time.'
                            'Selecting a particular payment method means you are agreeing to the terms of service of the Company’s processing partners and your financial institution. You will bear all fees that may be charged by such processing partners and/or your financial institution (if any) for the payment method you have selected.\n\n'
                               'Taxes:\n'
                                'You agree that this Agreement shall be subject to all prevailing statutory taxes, duties, fees, charges and/or costs, however denominated, as may be in force in Nigeria and in connection with any future taxes that may be introduced at any point of time. You further agree to use your best efforts to do everything necessary and required by the relevant laws to enable, assist and/or defend the Company to claim or verify any input tax credit, set off, rebate or refund in respect of any taxes paid or payable in connection with the Service supplied under this Agreement.\n\n'
                                'License Grant & Restrictions\n'
                                'The Company and its licensor, where applicable, hereby grants you a revocable, non-exclusive, nontransferable, non- assignable, personal, limited license to use the Application and/or the Software, solely for your own personal, non- commercial purposes, subject to the Terms of Service herein. All rights not expressly granted to you are reserved by the Company and its licensor\n'
                                '(a) You shall not license, sublicense, sell, resell, transfer, assign, distribute or otherwise commercially exploit or make available to any third party the Application and/or the Software in any way; modify or make derivative works based on the Application and/or the Software; create internet “links” to the Application or “frame” or “mirror” the Software on any other server or wireless or internet-based device; reverse engineer or access the Software.\n'
                                 '(b) You may use the Software and/or the Application only for your personal, non-commercial purposes and shall not use the Software and/or the Application to: send spam or otherwise duplicative or unsolicited messages; send or store infringing, obscene, threatening, libelous, or otherwise unlawful or tortious material, including but not limited to materials harmful to children or violative of third party privacy rights; send material containing software viruses, worms, trojan horses or other harmful computer code, files, scripts, agents or programs; interfere with or disrupt the integrity or performance of the Software and/or the Application or the data contained therein; attempt to gain unauthorized access to the Software and/or the Application or its related systems or networks; or Impersonate any person or entity or otherwise misrepresent your affiliation with a person or entity to abstain from any conduct that could possibly damage the Company’s reputation or amount to being disreputable.\n\n'
                                'Intellectual Property Ownership:\n'
                                'The Company and its licensors, where applicable, shall own all right, title and interest, including all related intellectual property rights, in and to the Software and/or the Application and by extension, the Service and any suggestions, ideas, enhancement requests, feedback, recommendations or other information provided by you or any other party relating to the Service.\n'
                                  'The Terms of Service do not constitute a sale agreement and do not convey to you any rights of ownership in or related to the Service, the Software and/or the Application, or any intellectual property rights owned by the Company and/or its licensors. The Company’s name, the Company’s logo, the'
                                  'Service, the Software and/or the Application and the third party transportation providers’ logos and the product names associated with the Software and/or the Application are trademarks of the Company or third parties, and no right or license is granted to use them.'
                              'For the avoidance of doubt, the term “the Software” and “the Application” herein shall include its respective components, processes and design in its entirety.',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ); });
  }
}
