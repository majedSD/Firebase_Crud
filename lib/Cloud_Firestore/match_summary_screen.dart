import 'package:flutter/material.dart';
import 'package:frebase_crud/Model/match_summary.dart';

class MatchSummaryScreen extends StatefulWidget {
  const MatchSummaryScreen({super.key, required this.matchDetails});

  final MatchSummary matchDetails;

  @override
  State<MatchSummaryScreen> createState() => _MatchSummaryScreenState();
}

class _MatchSummaryScreenState extends State<MatchSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Summary Screen'),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.matchDetails.title,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                Text(widget.matchDetails.goal,
                    style:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Time:${widget.matchDetails.time}',
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Total Time:${widget.matchDetails.totalTime}',
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
