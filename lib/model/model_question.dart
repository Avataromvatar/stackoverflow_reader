// {
//       "tags": [
//         "java",
//         "android"
//       ],
//       "owner": {
//         "account_id": 23575362,
//         "reputation": 1,
//         "user_id": 17615087,
//         "user_type": "registered",
//         "profile_image": "https://lh3.googleusercontent.com/a/AATXAJwfGfQmuSZy_2iQaZ4b_5M5J4hLyyoLgGhL5DlK=k-s256",
//         "display_name": "natasha rondot",
//         "link": "https://stackoverflow.com/users/17615087/natasha-rondot"
//       },
//       "is_answered": false,
//       "view_count": 12,
//       "answer_count": 0,
//       "score": 0,
//       "last_activity_date": 1639136737,
//       "creation_date": 1639136573,
//       "last_edit_date": 1639136737,
//       "question_id": 70303994,
//       "content_license": "CC BY-SA 4.0",
//       "link": "https://stackoverflow.com/questions/70303994/i-cant-get-the-total-price-of-my-products-android-sudio-java",
//       "title": "I can&#39;t get the total price of my products android sudio java?"
//     }

import 'dart:convert';

class AppModelQuestion
{
  bool isTrue = false;

  String title = '';
  String description = '';
  int raw_date = -1;
  String date = '';
  String author = '';
  int id=-1;
  AppModelQuestion();
  AppModelQuestion.fromJson(String json)
  {
   var map = jsonDecode(json);
    if (map is Map<String, dynamic>) {
      if (map.containsKey('owner') &&
          map.containsKey('title') &&
          map.containsKey('creation_date')
          && map.containsKey('question_id')
        ) {
          try { 
             if(map['owner'] is Map<String, dynamic>)
             {
               if(map['owner'].containsKey('display_name'))
               {
                  title = map['title'];
                  author = map['owner']['display_name'];
                  raw_date = map['creation_date'];
                  date = DateTime.fromMillisecondsSinceEpoch(raw_date*1000).toIso8601String();
                  id = map['question_id'];
                  isTrue = true;
               }
             }
          } catch (e) {
            isTrue = false;
            print('ERROR: Create AppModelQuestion from $json\n$e');
          }  
           
          }
    }
  }
}