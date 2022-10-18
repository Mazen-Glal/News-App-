import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview.dart';

Widget itemShow( article,context )
{
  return InkWell(
    onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(article['url'])
          )
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:  DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
              )
            ),
          ),
          const SizedBox(width: 15,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    '${article['title']} ',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5,),
                  Text('${article['publishedAt']}',style: const TextStyle(color: Colors.grey),),
                ],
              )
          ),
        ],
      ),
    ),
  );
}
