import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../providers/jobs_provider.dart';
import '../services/ai_agent.dart';

class AIGuideButton extends StatelessWidget {
  final String screen;

  const AIGuideButton({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF1E4CA1),
      child: const Icon(Icons.smart_toy),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          builder: (_) => _AIAgentChat(screen: screen),
        );
      },
    );
  }
}

class _AIAgentChat extends StatefulWidget {
  final String screen;
  const _AIAgentChat({required this.screen});

  @override
  State<_AIAgentChat> createState() => _AIAgentChatState();
}

class _AIAgentChatState extends State<_AIAgentChat> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final jobs = Provider.of<JobsProvider>(context);
    final ai = AIAgent(profile: profile, jobs: jobs);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text("Ask Shanta tAI", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  final msg = messages[index];
                  final isUser = msg["sender"] == "user";

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(msg["text"]!),
                    ),
                  );
                },
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Ask something...",
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    String userMsg = controller.text.trim();
                    if (userMsg.isEmpty) return;

                    setState(() {
                      messages.add({"sender": "user", "text": userMsg});
                    });

                    String aiResponse = ai.ask(userMsg, widget.screen);

                    setState(() {
                      messages.add({"sender": "ai", "text": aiResponse});
                    });

                    controller.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
