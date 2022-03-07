import 'package:flutter/material.dart';
import 'package:news_blender_app/Layout/Cubit/cubit.dart';
import 'package:news_blender_app/modules/Webview/web_view.dart';

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(url:"${article['url']}")));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(8.0),
  
    child: Row(children: [
  
      Container(
  
        width: 120,
  
        height: 120,
  
        decoration: BoxDecoration(
  
          borderRadius: BorderRadius.circular(10),
  
          image: DecorationImage(
  
              image:NewsCubit.get(context).isShow? NetworkImage("${article['urlToImage']}") : NetworkImage("https://comnplayscience.eu/app/images/notfound.png"),
  
              fit: BoxFit.cover
  
          ),
  
        ),
  
      ),
  
      SizedBox(width: 20,),
  
      Expanded(
  
        child: Container(
  
          height: 120,
  
          child: Column(
  
            mainAxisAlignment: MainAxisAlignment.start,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Expanded(child:
  
              Text("${article['title']}",style: Theme.of(context).textTheme.bodyText1,maxLines: 2,overflow: TextOverflow.ellipsis,)),
  
              Text("${article['publishedAt']}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w700))
  
  
  
            ],),
  
        ),
  
      )
  
    ],),
  
  ),
);