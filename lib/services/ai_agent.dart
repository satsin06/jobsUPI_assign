import 'package:jobsupi_assignment/providers/profile_provider.dart';
import 'package:jobsupi_assignment/providers/jobs_provider.dart';

class AIAgent {
  final ProfileProvider profile;
  final JobsProvider jobs;

  AIAgent({required this.profile, required this.jobs});

  String ask(String question, String screen) {
    question = question.toLowerCase();

    if (screen == "profile") {
      if (question.contains("what is this screen")) {
        return "This is the Profile Creation screen where you enter name, age, job role, experience and address.";
      }
      if (question.contains("how do i save")) {
        return "Fill all fields and click on the Save Profile button.";
      }
      if (question.contains("why")) {
        return "Your profile helps us show more relevant job recommendations.";
      }
    }

    if (screen == "jobs") {
      if (question.contains("what jobs are available")) {
        return "There are ${jobs.jobs.length} jobs currently listed. You can filter by role or experience.";
      }

      if (question.contains("best job") ||
          question.contains("recommend") ||
          question.contains("suggest")) {
        final preferredJobs =
            jobs.jobs.where((job) {
              return job.title.toString().toLowerCase().contains(
                profile.role.toLowerCase(),
              );
            }).toList();

        if (preferredJobs.isEmpty) {
          return "Based on your profile, I don't see an exact match, but feel free to explore all jobs listed.";
        } else {
          return "Based on your profile (${profile.role}), I recommend applying for '${preferredJobs.first.title}' with ${preferredJobs.first.experience} experience required.";
        }
      }
    }

    if (question.contains("hello") || question.contains("hi")) {
      return "Hi! How can I guide you today?";
    }

    if (question.contains("help")) {
      return "You can ask me things like:\n• How do I use this screen?\n• Which job should I apply for?\n• What details should I enter?\n• What jobs match my profile?";
    }

    return "I’m not sure about that, but you can ask me about profile creation, job filters or recommendations.";
  }
}
