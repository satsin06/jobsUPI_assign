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
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          "assets/shanta/happy.png",
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.smart_toy, size: 30, color: Colors.white);
          },
        ),
      ),
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
  String shantaEmotion = "sushing";
  bool isTyping = false;

  void updateEmotionFromUserMessage(String msg) {
    msg = msg.toLowerCase();

    if (msg.contains("sad") || msg.contains("upset") || msg.contains("cry")) {
      shantaEmotion = "crying";
    } else if (msg.contains("help") || msg.contains("issue")) {
      shantaEmotion = "thinking";
    } else if (msg.contains("job") || msg.contains("recommend")) {
      shantaEmotion = "happy";
    } else if (msg.contains("what") || msg.contains("how")) {
      shantaEmotion = "thinking";
    } else if (msg.contains("hello") || msg.contains("hi")) {
      shantaEmotion = "happy";
    } else {
      shantaEmotion = "surprised_full";
    }
  }

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
            const Text(
              "Ask Shanta tAI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),

            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child:
                        messages.isEmpty
                            ? _buildSuggestions()
                            : ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (_, index) {
                                final msg = messages[index];
                                final isUser = msg["sender"] == "user";

                                return Align(
                                  alignment:
                                      isUser
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 12,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color:
                                          isUser
                                              ? Colors.blue[100]
                                              : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(msg["text"]!),
                                  ),
                                );
                              },
                            ),
                  ),

                  if (isTyping) buildTypingIndicator(),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Ask something...",
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () async {
                    String userMsg = controller.text.trim();
                    if (userMsg.isEmpty) return;

                    setState(() {
                      messages.add({"sender": "user", "text": userMsg});
                      updateEmotionFromUserMessage(userMsg);
                      isTyping = true;
                      shantaEmotion = "thinking";
                    });

                    controller.clear();

                    await Future.delayed(const Duration(seconds: 1));

                    String aiResponse = ai.ask(userMsg, widget.screen);

                    setState(() {
                      messages.add({"sender": "ai", "text": aiResponse});
                      isTyping = false;

                      if (aiResponse.contains("recommend")) {
                        shantaEmotion = "happy";
                      } else if (aiResponse.contains("sorry") ||
                          aiResponse.contains("not sure")) {
                        shantaEmotion = "sad";
                      } else {
                        shantaEmotion = "thinking";
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<String> getSuggestedQuestions() {
    if (widget.screen == "profile") {
      return [
        "What details should I fill?",
        "Why is profile needed?",
        "How do I save my profile?",
      ];
    }

    return [
      "Which job suits me?",
      "How do filters work?",
      "What jobs are available?",
    ];
  }

  Widget _buildSuggestions() {
    final suggestions = getSuggestedQuestions();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Try asking:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                suggestions.map((q) {
                  return GestureDetector(
                    onTap: () => _sendSuggestion(q),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Text(
                        q,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  void _sendSuggestion(String question) {
    setState(() {
      messages.add({"sender": "user", "text": question});
    });

    final profile = Provider.of<ProfileProvider>(context, listen: false);
    final jobs = Provider.of<JobsProvider>(context, listen: false);
    final ai = AIAgent(profile: profile, jobs: jobs);

    final aiResponse = ai.ask(question, widget.screen);

    setState(() {
      messages.add({"sender": "ai", "text": aiResponse});
    });
  }

  Widget buildTypingIndicator() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Image.asset("assets/shanta/sushing.png", width: 45),
        ),
        const SizedBox(width: 8),
        const Text(
          "Shanta is typing...",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
