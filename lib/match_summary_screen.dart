import 'package:flutter/material.dart';
import 'package:frebase_crud/Model/match_summary.dart';

class MatchSummaryScreen extends StatefulWidget {
  const MatchSummaryScreen({super.key,required this.matchSummary});
  final MatchSummary matchSummary;
  @override
  State<MatchSummaryScreen> createState() => _MatchSummaryScreenState();
}

class _MatchSummaryScreenState extends State<MatchSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchSummary.id),
        backgroundColor:Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:SizedBox(
          height:120,
          width: double.infinity,
          child: Card(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.matchSummary.id,style:const TextStyle(
                      color:Colors.grey,
                      fontWeight:FontWeight.bold,
                      fontSize: 20,
                    ),),
                    Text(widget.matchSummary.goal,style:const TextStyle(
                      color:Colors.black,
                      fontWeight:FontWeight.bold,
                      fontSize: 20,
                    ),),
                    Text('Time:${widget.matchSummary.time}',style:const TextStyle(
                      color:Colors.black,
                      fontWeight:FontWeight.bold,
                      fontSize: 16,
                    ),),
                    Text('Total Time:${widget.matchSummary.totalTime}',style:const TextStyle(
                      color:Colors.black,
                      fontWeight:FontWeight.bold,
                      fontSize: 16,
                    ),)
                  ],
                ),
              ),
        )
        ),
    );
  }
}
