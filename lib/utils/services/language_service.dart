import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'welcome': 'Welcome,',
          'sign_in_to_continue': 'Sing in to continue!',
          'mobile_no': 'Mobile No.',
          'enter_mobile_no': 'Enter Mobile No.',
          'login': 'Login',
          'sign_in': 'Sign In',
          'sign_up': 'Sign Up',
          'send_otp': 'Send OTP',
          'we_will_send_you_a_otp_to_login': 'We will send you a OTP to login',
          'select_language': 'Select Language',
          'languages': 'Languages',
          'do_not_have_account': 'Don\'t  have an account?  ',
          'please_enter_mobile_no': 'Please enter mobile no.',
          'please_enter_valid_mobile_no': 'Please enter valid mobile no.',
          'please_wait': 'Please Wait',
          'are_you_sure_you_want_to_log_out':
              'Are You Sure You Want to Logout?',
          'log_out': 'Log Out',
          'cancel_in': 'Cancel',
          'okay': 'Okay',
          'network_error': 'Network Error!',
          'network_error_desc':
              'There is some issue with your internet connection. Please check your internet and try again.',
          'something_went_wrong': 'Something went wrong!',
          '404_err_msg': 'Method Not Found  Status Code 404',
          'internal_server_err': 'Internal Server Error!',
          'connection_timeout_err': 'Connection Timeout!',
          'receive_timeout': 'Receive Timeout!',
          'send_timeout': 'Send Timeout!',
          'req_canceled': 'Request Cancelled!',
          'err_occurred': 'Error Occurred!',
          'pls_check_your_input': 'Please Check Your Input!',
          'are_you_sure': 'Are your sure?',
          'go_back_desc':
              'Do you want to go back without verifying your account?',
          'no': 'No',
          'yes': 'Yes',
          'otp_verification': 'OTP Verification,',
          'verify_otp_to_continue': 'Verify OTP to continue!',
          'verify_and_proceed': 'Verify & Proceed',
          'change_mobile_no': 'Want to change mobile no.? ',
          'click_here': 'Click here',
          'enter_otp': 'Enter OTP',
          'do_not_receive_otp': 'Don\'t receive the OTP? ',
          'resend_otp': 'Resend OTP',
          'we_have_sent_a_otp_to_mobile_no':
              'We have sent a OTP to your mobile no.',
          'register': 'Let\'s Get Started,',
          'create_new_account': 'Create a new account!',
          'customer_name': 'Customer Name*',
          'customer_name_err': 'Please enter customer name',
          'enter_customer_name': 'Enter Customer Name',
          'shop_name': 'Shop Name*',
          'shop_name_err': 'Please enter shop name!',
          'enter_shop_name': 'Enter Shop Name',
          'l_n_err': 'Please enter last name!',
          'l_mobile_no': 'Mobile No.*',
          'h_mobile_no': 'Enter Mobile No.',
          'e_mobile_no': 'Please enter valid mobile no.',
          'l_email': 'Email Address*',
          'h_email': 'Enter Email Address',
          'e_email': 'Please enter your email address',
          'l_pan_no': 'PAN No.',
          'h_pan_no': 'Enter Pan No.',
          'e_pan_no': 'Please enter valid PAN no.',
          'l_gst_no': 'GST No.',
          'h_gst_no': 'Enter Gst No.',
          'e_select_role': 'Please select role',
          'e_gst_no': 'Please enter valid GST No.',
          'l_ima': 'I\'m a',
          'dealer': 'Dealer',
          'shopkeeper': 'ShopKeeper',
          'hawkers': 'Hawkers',
          'already_have_an_account': 'Already have an account? ',
          'try_again': 'Try Again',
          'gold_rate': 'Gold Rate',
          'are_you_sure_to_exit_app': 'Are you sure you want to exit the app?',
          'exit_app': "Exit App",
          'loading': "Loading...",
          'add_to_cart': "Add To Cart",
          'buy_now': "Buy Now",
          'done': "Done",
          'cancel': "Cancel",
          'shopping_cart': "Shopping Cart",
          'no_data_found': "No Data Found!",
          'logout': "Logout",
          'gold_purity': "Gold Purity: ",
          'weight': "Weight (mg): ",
          'price': "Price (Per Product): ",
          'product_total': "Product Total: ",
          'order_total': "Order Total: ",
          'place_order': "Place Order",
          'your_cart_is_empty': "Your cart is empty!",
          'order_processing_please_wait':
              "Your Order is in process please wait and don\'t close the screen until status updated!",
          'order_history': "Order History",
          'order_no': "Order No.: ",
          'order_date': "Order Date: ",
          'total_quantity': "Total Quantity",
          'total_price': "Total Price",
          'order_status': "Status",
          'order_details': "Order Details",
          'karat': "Karat",
          'quantity': "Quantity",
          'making_charge': "Making Charges",
          'total_weight': "Total Weight",
          'gold_purity_diff': "Gold Purity",
          'change_language': "Change Language",
          'are_you_sure_to_logout': "Are you sure want to logout ?",
          'home': "Home",
          'profile': "Profile",
          'gold_rate_pr_gram': "Gold Rate (per gm)",
          'gold_price': 'Gold Price',
          'total': 'Total',
          'storage_permission_err':
              'You have to manually allow storage permission by going to (e.x. you can hold on app icon to go their )  NMK Noise Pins LLP "App Info" -> "App Permissions" -> "Photos and Videos" -> "Allow" to use this feature!',
          'download_invoice': 'Download Invoice',
          'click_to_open': 'Tap To Open Invoice',
          'we_are_better_than_ever': 'We\'re better than ever',
          'we_added_lots_of_new_features_fix_some_bugs':
              'we added lots of new features and \nfix some bugs to make your experience as \nsmooth as possible',
          'update_app': 'UPDATE APP',
          'not_now': 'Not Now',
          'edit_profile': 'Edit Profile',
          'full_name': 'Full Name*',
          'enter_full_name': 'Enter Full Name',
          'edit': 'Edit',
          'dynamic_link_click_below':
              '👇 Click on below link to check this design 👇',
          'save': 'Save',
          'stamp': 'Stamp',
          'your_cart_item_will_be_removed_after_six_hours':
              '● Your cart item will be removed after 6 hours ',
          'or': 'or',
          'payment_screen': 'Payment Screen',
          'payment_instruction':
              'Please do not press the back button or close the app while we are processing your payment.',
          'payment_options': 'Payment Options',
          'scan_qr': 'Scan QR',
          'self_pickup': 'Self Pickup',
          'online': 'Online',
          'order_placed': 'Order Placed!',
          'back_to_home': 'Back to Home',
          'failure': 'Failure!',
          'got_it': 'Got it!',
          'article_no': 'Article No.: ',
          'making_charge_new': 'Making Charge: ',
          'article_number': 'Article No.',
          'refund_article': 'Refund Article',
          'order_number': 'Order No.',
          'article_number_new': 'Article No.',
          'order_price': 'Order Price',
          'refund_amount': 'Refund Amount',
          'status': 'Status',
          'refund_date': 'Refund Date',
          'apply_filters': 'Apply Filters',
          'enter_article_no': 'Enter Article No.',
          'apply_filter': 'Apply Filter',
          'clear': 'Clear',
          'weight_mg': 'Weight (mg)',
          'no_additional_fees_on_self_pickup': 'No additional fees on self pickup.',
          'an_additional_fees_on_online': 'An additional fee of 2.75% will be applied for online payments.',
          'your_order_will_approved_shortly': 'your order will be approved shortly.',
          'delete_item': 'Delete Item?',
          'are_you_sure_to_delete': 'Are you sure want to delete this item from cart?',
          'delete_account': 'Delete Account',
          'are_you_sure_to_delete_account': 'Are you sure want to delete your account?',
        },
        'hi_IN': {
          'welcome': 'स्वागत है,',
          'sign_in_to_continue': 'जारी रखने के लिए साइन इन करें!',
          'mobile_no': 'मोबाइल नंबर',
          'enter_mobile_no': 'मोबाइल नंबर दर्ज करें',
          'login': 'लॉगिन',
          'sign_in': 'साइन इन करें',
          'sign_up': 'साइन अप करें',
          'send_otp': 'ओटीपी भेजें',
          'we_will_send_you_a_otp_to_login':
              'लॉगिन करने के लिए हम आपको एक ओटीपी भेजेंगे',
          'select_language': 'भाषा चुनें',
          'languages': 'भाषाएँ',
          'do_not_have_account': 'खाता नहीं है? ',
          'please_enter_mobile_no': 'कृपया मोबाइल नंबर दर्ज करें।',
          'please_enter_valid_mobile_no': 'कृपया वैलिड मोबाइल नंबर दर्ज करें।',
          'please_wait': 'कृपया प्रतीक्षा करें',
          'are_you_sure_you_want_to_log_out': 'क्या आप लॉग आउट करना चाहते हैं?',
          'log_out': 'लॉग आउट',
          'cancel_in': 'रद्द करें',
          'okay': 'ठीक है',
          'network_error': 'नेटवर्क त्रुटि!',
          'network_error_desc':
              'आपके इंटरनेट कनेक्शन में कुछ समस्या है। कृपया अपना इंटरनेट चेक करें और पुनः प्रयास करें।',
          'something_went_wrong': 'कुछ गड़बड़ हो गई है!',
          '404_err_msg': 'मैथड नहीं मिला स्थिति कोड 404',
          'internal_server_err': 'आंतरिक सर्वर त्रुटि!',
          'connection_timeout_err': 'कनेक्शन समय समाप्ति!',
          'receive_timeout': 'समय समाप्ति प्राप्त करें!',
          'send_timeout': 'समय समाप्ति भेजें!',
          'req_canceled': 'अनुरोध रद्द कर दिया गया है!',
          'err_occurred': 'त्रुटि हुई!',
          'pls_check_your_input': 'कृपया अपनी इनपुट जांचें!',
          'are_you_sure': 'क्या आप सुनिश्चित हैं?',
          'go_back_desc':
              'क्या आप अपना खाता सत्यापित किए बिना पीछे जाना चाहते हैं?',
          'no': 'नहीं',
          'yes': 'हाँ',
          'otp_verification': 'ओटीपी सत्यापन,',
          'verify_otp_to_continue': 'आगे बढ़ने के लिए ओटीपी सत्यापित करें!',
          'verify_and_proceed': 'सत्यापित करें और आगे बढ़ें',
          'change_mobile_no': 'मोबाइल नंबर बदलना चाहते हैं? ',
          'click_here': 'यहाँ क्लिक करें',
          'enter_otp': 'ओटीपी दर्ज करें',
          'do_not_receive_otp': 'ओटीपी प्राप्त नहीं हुई? ',
          'resend_otp': 'ओटीपी फिर से भेजें',
          'we_have_sent_a_otp_to_mobile_no':
              'हमने आपके मोबाइल नंबर पर ओटीपी भेज दी है।',
          'register': 'शुरू करते हैं,',
          'create_new_account': 'नया खाता बनाएं।',
          'customer_name': 'ग्राहक का नाम*',
          'customer_name_err': 'कृपया ग्राहक का नाम दर्ज करें।',
          'enter_customer_name': 'ग्राहक का नाम दर्ज करें',
          'shop_name': 'दुकान का नाम*',
          'shop_name_err': 'कृपया दुकान का नाम दर्ज करें।',
          'enter_shop_name': 'दुकान का नाम दर्ज करें',
          'l_n_err': 'कृपया अंतिम नाम दर्ज करें!',
          'l_mobile_no': 'मोबाइल नंबर*',
          'h_mobile_no': 'मोबाइल नंबर दर्ज करें',
          'e_mobile_no': 'कृपया वैध मोबाइल नंबर दर्ज करें।',
          'l_email': 'ईमेल पता*',
          'h_email': 'ईमेल पता दर्ज करें',
          'e_email': 'कृपया अपना ईमेल पता दर्ज करें',
          'l_pan_no': 'पैन नंबर',
          'h_pan_no': 'पैन नंबर दर्ज करें',
          'e_pan_no': 'कृपया वैध पैन नंबर दर्ज करें।',
          'l_gst_no': 'जीएसटी नंबर',
          'h_gst_no': 'जीएसटी नंबर दर्ज करें',
          'e_select_role': 'कृपया भूमिका चुनें',
          'e_gst_no': 'कृपया वैध जीएसटी नंबर दर्ज करें।',
          'l_ima': 'मैं हूं',
          'dealer': 'डीलर',
          'shopkeeper': 'शॉपकीपर',
          'hawkers': 'फेरी वाले',
          'already_have_an_account': 'पहले से ही खाता है? ',
          'try_again': 'पुनः प्रयास करें',
          'gold_rate': 'Gold Rate',
          'are_you_sure_to_exit_app': 'क्या आप ऐप से बाहर निकलना चाहते हैं?',
          'exit_app': "ऐप बंद करें",
          'loading': "लोड हो रहा है...",
          'add_to_cart': "कार्ट में जोड़ें",
          'done': "हो गया",
          'cancelcancel': "रद्द करें",
          'shopping_cart': "शॉपिंग कार्ट",
          'no_data_found': "कोई डेटा नहीं मिला!",
          'logout': "लॉग आउट",
          'gold_purity': "सोने की पवित्रता: ",
          'weight': "वजन (मिलीग्राम): ",
          'price': "प्राइस (पर प्रोडक्ट): ",
          'product_total': "प्रोडक्ट टोटल: ",
          'order_total': "ऑर्डर टोटल: ",
          'place_order': "ऑर्डर प्लेस करें",
          'your_cart_is_empty': "आपका कार्ट खाली है!",
          'order_processing_please_wait':
              "आपका ऑर्डर प्रसंस्करण हो रहा है, कृपया प्रतीक्षा करें...",
          'order_history': 'आर्डर हिस्ट्री',
          'order_no': 'आर्डर नंबर: ',
          'order_date': 'आर्डर डेट: ',
          'total_quantity': 'कुल मात्रा',
          'total_price': 'कुल मूल्य',
          'order_status': 'स्टेटस',
          'order_details': 'आर्डर डिटेल्स',
          'karat': 'कैरेट',
          'quantity': 'मात्रा',
          'making_charge': 'मेकिंग चार्ज',
          'total_weight': 'कुल वजन',
          'gold_purity_diff': 'सोने की पवित्रता',
          'change_language': 'भाषा बदलें',
          'are_you_sure_to_logout': 'क्या आप लॉग आउट करना चाहते हैं?',
          'home': "होम",
          'profile': "प्रोफ़ाइल",
          'buy_now': "अभी खरीदें",
          'gold_rate_pr_gram': "सोने का भाव (प्रति ग्राम)",
          'gold_price': 'सोने की कीमत',
          'total': 'टोटल',
          'storage_permission_err':
              'NMK Noise Pins LLP "App Info" -> "App Permissions" -> "Photos and Videos" -> "Allow" पर जाकर आपको मैन्युअल रूप से स्टोरेज की अनुमति देनी होगी (उदाहरण के लिए आप ऐप आइकन पर जाकर उनके पास जा सकते हैं) यह सुविधा!',
          'download_invoice': 'इनवाइस को डाउनलोड करो',
          'click_to_open': 'चालान खोलने के लिए टैप करें',
          'we_are_better_than_ever': 'हम पहले से कहीं बेहतर हैं।',
          'we_added_lots_of_new_features_fix_some_bugs':
              'हमने आपके अनुभव को यथासंभव सुगम बनाने के लिए\n बहुत सी नई सुविधाएँ जोड़ी हैं और कुछ बग्स को \nठीक किया है।',
          'update_app': 'अपडेट ऐप',
          'not_now': 'अभी नहीं',
          'edit_profile': 'प्रोफ़ाइल संपादित करें',
          'full_name': 'पूरा नाम*',
          'enter_full_name': 'पहला नाम दर्ज करें',
          'edit': 'संपादित करें',
          'dynamic_link_click_below':
              '👇 इस डिज़ाइन को देखने के लिए नीचे दिए गए लिंक पर क्लिक करें 👇',
          'save': 'सेव',
          'stamp': 'स्टेमप',
          'your_cart_item_will_be_removed_after_six_hours':
              '● आपका कार्ट आइटम 6 घंटे के बाद हटा दिया जाएगा ',
          'or': 'अथवा',
          'payment_screen': 'पेमेंट स्क्रीन',
          'payment_instruction':
              'कृपया हम आपके पेमेंट को प्रोसेस कर रहे हैं, कृपया वापस जाने वाले बटन या ऐप को बंद न करें।',
          'payment_options': 'भुगतान विकल्प',
          'scan_qr': 'QR स्कैन करें',
          'self_pickup': 'सेल्फ पिकअप',
          'online': 'ऑनलाइन',
          'order_placed': 'ऑर्डर प्लेस हुआ!',
          'back_to_home': 'वापस जाओ',
          'failure': 'असफलता!',
          'got_it': 'ठीक है',
          'article_no': 'आरटिकल नंबर: ',
          'making_charge_new': 'मेकिंग चार्ज: ',
          'article_number': 'आरटिकल नंबर',
          'refund_article': 'रीफनड आरटीकल',
          'order_number': 'ऑर्डर नंबर',
          'article_number_new': 'आरटीकल नंबर',
          'order_price': 'ऑर्डर मूल्य',
          'refund_amount': 'रीफनड मूल्य',
          'status': 'स्टेटस',
          'refund_date': 'रीफनड तारीख',
          'apply_filters': 'फ़िल्टर लागू करें',
          'enter_article_no': 'आरटिकल संख्या दर्ज करें',
          'apply_filter': 'फ़िल्टर लागू करें',
          'clear': 'साफ़',
          'weight_mg': 'वजन (मिलीग्राम)',
          'no_additional_fees_on_self_pickup': 'सेल्फ पिकअप पर कोई अतिरिक्त शुल्क नहीं।',
          'an_additional_fees_on_online': 'ऑनलाइन भुगतान के लिए 2.75% का अतिरिक्त शुल्क लागू किया जाएगा।',
          'your_order_will_approved_shortly': 'आपका ऑर्डर शीघ्र ही स्वीकृत हो जाएगा।',
          'delete_item': 'आइटम हटाएं?',
          'are_you_sure_to_delete': 'क्या आप वाकई इस आइटम को कार्ट से हटाना चाहते हैं?',
          'delete_account': 'खाता हटा दो',
          'are_you_sure_to_delete_account': 'क्या आप इस खाते को हटाना चाहते हैं?',
        },
      };
}
