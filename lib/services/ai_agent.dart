import 'package:jobsupi_assignment/providers/profile_provider.dart';
import 'package:jobsupi_assignment/providers/jobs_provider.dart';

class AIAgent {
  final ProfileProvider profile;
  final JobsProvider jobs;

  AIAgent({required this.profile, required this.jobs});

  String ask(String question, String screen) {
    question = question.toLowerCase().trim();

    if (question.contains("hello") || question.contains("hi")) {
      return "Namaste beta! 👋 I'm Shanta tAI. Tell me, how can I guide you today?";
    }

    if (question.contains("help") || question.contains("guide")) {
      return "Of course, I'm right here to help! 😊\n\nYou can ask things like:\n\n• What is this screen for?\n• What details should I fill?\n• Which job suits me?\n• How do job filters work?\n• Suggest a job for me.";
    }

    if (screen == "profile") {
      if (question.contains("what") && question.contains("screen")) {
        return "This is your Profile Creation screen, beta. 💼\n\nHere you enter basic details like:\n• Name\n• Age\n• Job role you're aiming for\n• Experience\n• Address\n\nA complete profile helps us match you with better jobs!";
      }

      if (question.contains("what") && question.contains("fill")) {
        return "Fill in the details that describe you best:\n\n• Your full name\n• Your age\n• The role you want (e.g., Flutter Developer)\n• Your experience in years\n• Your current address\n\nOnce done, just tap **Save & Continue**.";
      }

      if (question.contains("why") || question.contains("benefit")) {
        return "Arrey, very important beta! 🙌\n\nYour profile helps me:\n• Recommend jobs that match your role\n• Avoid showing irrelevant jobs\n• Improve your job search experience\n\nThink of it like your résumé summary.";
      }

      if (question.contains("save") || question.contains("submit")) {
        return "Very simple! 😊 After filling all fields, just tap **Save Profile**.\nI will store your information so I can give smarter job suggestions.";
      }

      if (question.contains("experience")) {
        return "Enter your total years of work experience — even if it's internships. It helps me filter jobs correctly for you.";
      }
    }

    if (screen == "jobs") {
      if (question.contains("what") && question.contains("job")) {
        return "Right now, I see **${jobs.jobs.length} jobs** listed for you. 🎯\nYou can filter them by:\n• Job role\n• Minimum experience\n• Expected salary\n\nTell me your preference, I can guide more.";
      }

      if (question.contains("filter")) {
        return "Filters help you narrow down job listings:\n\n• **Role filter** → Shows only your desired job type.\n• **Experience filter** → Jobs matching your experience.\n• **Salary filter** → Helps you aim for your salary range.\n\nJust apply the filters to refine results.";
      }

      if (question.contains("best") ||
          question.contains("recommend") ||
          question.contains("suggest") ||
          question.contains("suit")) {
        final preferredJobs =
            jobs.jobs.where((job) {
              return job.title.toLowerCase().contains(
                profile.role.toLowerCase(),
              );
            }).toList();

        if (preferredJobs.isEmpty) {
          return "Hmm… I don't see an exact match for **${profile.role}**, beta.\nBut don't worry! Explore the list — many good opportunities are waiting. 💪";
        } else {
          final job = preferredJobs.first;
          return "For your profile (${profile.role}), I recommend:\n\n✨ **${job.title}**\nExperience needed: ${job.experience} years\n\nLooks like a great match for you!";
        }
      }

      if (question.contains("suit")) {
        return "Tell me your preferred role or experience range, and I'll recommend the most suitable job.";
      }
    }

    if (question.contains("don't") ||
        question.contains("confuse") ||
        question.contains("idk")) {
      return "No worries beta, confusion is normal. 😊 Just ask me what you want to understand, and I'll explain clearly.";
    }

    return "Hmm, I'm not fully sure about that. But you can ask me about profile creation, job searching, filters, or recommendations. 😊";
  }
}
