import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:http/http.dart' as http;

import 'message.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> with TickerProviderStateMixin{
  final TextEditingController _messageContoller=TextEditingController();
  final ScrollController _scrolling =ScrollController();
  final List<Message>_message=[];
  bool _isloading =false;
  late AnimationController _animatedContainer;
  static const String _apikey="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";
  static const String _apiurl="https://openrouter.ai/api/v1/chat/completions";




@override
  void initState() {
    super.initState();

    _animatedContainer= AnimationController(vsync: this,
      duration: const Duration(milliseconds: 500)
    ) ;
    setState(() {
      _message.add(
          Message(Content: "Hello! Iam your AI Assistant. How can I help you Today?",
              isusr: false,
              timestamp: DateTime.now(),
              id: _generateID()));

    });
  }

  String _generateID(){
    return DateTime.now().microsecondsSinceEpoch.toString()+Random().nextInt(1000).toString();
  }

  Future<void> _sendmessage()async{
    if(_messageContoller.text.trim().isEmpty) return;

    final userMessage=_messageContoller.text.trim();
    _messageContoller.clear();
    setState(() {
      _message.add(Message(
          Content: userMessage,
          isusr: true,
          timestamp: DateTime.now(),
          id: _generateID()));

      _isloading=true;
    });
    _scrollToButtom();

    try{
      final reponse =await _callopenRouterApi(userMessage);
      setState(() {
        _message.add(Message(
            Content: reponse,
            isusr: false,
            timestamp: DateTime.now(),
            id: _generateID()));

        _isloading=false;
      });
    }catch(e){
      setState(() {
        _message.add(Message(
            Content: "Sorry,I Couldn't process Your request. Please Try again.",
            isusr: false,
            timestamp: DateTime.now(),
            id: _generateID()));
        _isloading=false;
      });
    }
    _scrollToButtom();
  }

  Future<String>_callopenRouterApi(String message)async{
    final headers={
      'Authorization':'Bearer $_apikey',
      'Content-Type':'application/json',
      'HTTP-Referer':"https://myportfolio-fb771.web.app/",
      'X-Title':'AI Chat Assistant',
    };


    final body =jsonEncode({
      'model':'google/gemma-3-4b-it:free',
      'messages':[
        {'role':'system','content':'You are a helpful AI assistant. Please Provide concise answers.'},
        {'role':'user','content':message},
      ],
      'max_tokens':2000,
      'temperature':0.7,

    });
    final response= await http.post(Uri.parse(_apiurl),
      headers: headers,
      body: body,
    );

    if(response.statusCode==200){
      final data =jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    }else {
      throw Exception('Failed to load response:: ${response.statusCode} - ${response.body}');
    }
  }

  void _scrollToButtom(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(_scrolling.hasClients){
        _scrolling.animateTo(
            _scrolling.position.maxScrollExtent,
            duration: const Duration(microseconds: 300),
            curve: Curves.easeOut);
      }
    });
  }



  @override
  void dispose() {
    _animatedContainer.dispose();
    _messageContoller.dispose();
    _scrolling.dispose();
    super.dispose();
  }




  Widget _buildAvatar (bool isuser){
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          gradient: isuser
              ?LinearGradient(colors: [Color(0xFF667EEA),Color(0XFF764BA2)])
              :LinearGradient(colors: [Color(0xFF11998E),Color(0xFF38EF7D)]),
          borderRadius: BorderRadius.circular(16)
      ),
      child: Icon(isuser?Icons.person: Icons.smart_toy,
        color: Colors.white,
        size: 16,
      ),
    );
  }



  Widget _bulidDot(int index){
  return AnimatedBuilder(animation: _animatedContainer,
      builder: (context,child){
       return Container(
         width: 8,
         height: 8,
         decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3+(sin(_animatedContainer.value*2*pi+index*0.5)*0.3),
            ),
                borderRadius: BorderRadius.circular(4)
         ),
       );
      }
  );
  }


  Widget _buildmessageBubble(Message message){
  return Padding(padding: EdgeInsets.only(bottom: 16),
  child: Row(
    mainAxisAlignment: message.isusr
    ?MainAxisAlignment.end
    :MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if(!message.isusr)_buildAvatar(false),
      SizedBox(width: 8),
      Flexible(child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width*0.75,
        ),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: message.isusr
              ?LinearGradient(colors: [
                Color(0xFF667EEA),Color(0XFF764BA2)
          ]):
              LinearGradient(colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.5),
              ]),
          borderRadius: BorderRadius.circular(20),
          border: message.isusr
            ?null:Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1
          ),
          boxShadow: [
            BoxShadow(
              color: message.isusr
                  ?Color(0XFF667EEA).withOpacity(0.3)
                  :Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ]
        ),
        child: message.isusr ?Text(message.Content,style: TextStyle(color: Colors.white,fontSize: 15),) :GptMarkdown(message.Content,style: TextStyle(color: Colors.white,fontSize: 15),),
      )
      ),
      SizedBox(width: 8,),
      if(message.isusr)_buildAvatar(true)
    ],
  ),
  );
  }


  Widget _buildinputArea(){
  if(_isloading){
    _animatedContainer.repeat();
  }else{
    _animatedContainer.stop();
  }
  return Container(
     padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    child:Row(
      children: [
        Expanded(child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            )
          ),
          child: TextField(controller: _messageContoller,
          maxLines: null,
          onSubmitted: (value){
            _sendmessage();
          },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Type Your message....",
              hintStyle: TextStyle(color: Colors.white60),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20, vertical: 16
              )
            ),
          ),

        )),
        SizedBox(
          width: 12,
        ),
        GestureDetector(
          onTap: _isloading ?null :_sendmessage,
          child: Container(
            decoration: BoxDecoration(
              gradient:_isloading
            ?LinearGradient(colors: [
             Colors.grey.withOpacity(0.3),
             Colors.grey.withOpacity(0.2),
              ]):
            LinearGradient(colors: [
           Color(0XFF667EEA), Color(0XFF764BA2)
      ]),
              borderRadius: BorderRadius.circular(50),
              boxShadow: _isloading
              ?[]
               :[
                BoxShadow(
                  color: Color(0xFF667EEA).withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),

                )
              ]
            ),
            child:
            Icon(_isloading? Icons.hourglass_empty:
              Icons.send_rounded,color: Colors.white,size: 20,),
          ),
        )
      ],
    ) ,
  );
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Container(
       decoration: BoxDecoration(
         gradient: LinearGradient(colors: [
           Color(0XFF0A0A0A),
           Color(0XFF1A1A2E),
           Color(0XFF16213E)
         ],
         begin:Alignment.topLeft ,
           end:Alignment.bottomRight,
         )
       ),
       child: SafeArea(child: Column(children: [
         Container(
           padding: EdgeInsets.all(20),
           child: Row(
             children: [
               Container(
                 padding: EdgeInsets.all(12),
                 decoration: BoxDecoration(
                   gradient: LinearGradient(colors: [
                     Color(0xFF667EEA),
                     Color(0XFF764BA2)
                     
                   ]),
                   borderRadius: BorderRadius.circular(16),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.2),
                       blurRadius: 12,
                       offset: Offset(0, 4),
                     ),
                   ]
                 ),
                 child: Icon(Icons.smart_toy_rounded,
                   color: Colors.white,
                   size: 24,
                 ),
               ),
               SizedBox(width: 16,),
               Expanded(child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("AI Assistant",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   Text("Ask me anything",
                     style: TextStyle(
                       color: Colors.white60,
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                     ),
                   )
                 ],
               )
               ),
               Container(
                 padding: EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Icon(Icons.more_vert,color: Colors.white70,),
               )
             ],
           )
         ),
         Expanded(child: ListView.builder(
           controller: _scrolling,
           padding: EdgeInsets.symmetric(horizontal: 20),
           itemCount: _message.length+(_isloading?1:0),
           itemBuilder: (context,index){
             if(index==_message.length &&_isloading){
               return Padding(padding: EdgeInsets.only(bottom: 16),
                 child: Row(
                   children: [
                     _buildAvatar(false),
                     SizedBox(
                       width: 8,
                     ),
                     Container(
                       padding: EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         color: Colors.white.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(
                           color: Colors.white.withOpacity(0.1),
                           width: 1,
                         )
                       ),
                       child: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           _bulidDot(0),
                           SizedBox(width: 4),
                           _bulidDot(1),
                           SizedBox(width: 4),
                           _bulidDot(2)
                         ],
                       ),
                     )
                   ],
                 ),
               );
             }
             return _buildmessageBubble(_message[index]);
           },
         )
         ),
         _buildinputArea()

       ],)),
     ),
    );
  }
}
