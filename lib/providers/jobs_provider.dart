import 'package:flutter/foundation.dart';
import 'package:jobsupi_assignment/model/job_model.dart';

class JobsProvider with ChangeNotifier {
  List<Job> jobs = [
    Job(title: "Flutter Developer", experience: "1-3 yrs", salary: "₹8L - ₹12L", location: 'Remote'),
    Job(title: "Python Developer", experience: "2-4 yrs", salary: "₹10L - ₹15L", location: 'Bangalore'),
    Job(title: "Full Stack Developer", experience: "3-5 yrs", salary: "₹12L - ₹18L", location: 'Hybrid'),
    Job(title: "Backend Developer", experience: "2-3 yrs", salary: "₹9L - ₹14L", location: 'Remote'),
    Job(title: "Frontend Developer", experience: "1-2 yrs", salary: "₹7L - ₹11L", location: 'Mumbai'),
    Job(title: "Data Scientist", experience: "3-5 yrs", salary: "₹15L - ₹20L", location: 'Bangalore'),
    Job(title: "Full Stack Developer", experience: "2-4 yrs", salary: "₹12L - ₹18L", location: 'Hybrid'),
    Job(title: "Mobile App Developer", experience: "1-3 yrs", salary: "₹8L - ₹13L", location: 'Remote'),
    Job(title: "UI/UX Designer", experience: "2-4 yrs", salary: "₹10L - ₹15L", location: 'Bangalore'),
    Job(title: "Backend Developer", experience: "3-5 yrs", salary: "₹12L - ₹18L", location: 'Hybrid'),
    Job(title: "DevOps Engineer", experience: "2-4 yrs", salary: "₹11L - ₹16L", location: 'Remote'),
    Job(title: "QA Engineer", experience: "1-3 yrs", salary: "₹7L - ₹10L", location: 'Chennai'),
    Job(title: "Project Manager", experience: "4-6 yrs", salary: "₹18L - ₹25L", location: 'Bangalore'),
    Job(title: "Software Architect", experience: "5-7 yrs", salary: "₹25L - ₹35L", location: 'Hybrid'),
    Job(title: "Cloud Engineer", experience: "3-5 yrs", salary: "₹15L - ₹22L", location: 'Remote'),
    Job(title: "Data Engineer", experience: "2-4 yrs", salary: "₹12L - ₹18L", location: 'Mumbai'),
  ];
}


