# Students Attendance Management System  

A comprehensive attendance management application for students and administrators. This app simplifies the process of tracking, marking, and reporting attendance while providing user-friendly features for both users and administrators.  

---

## Demo Video  
Check out the demo of the app on LinkedIn: [Attendance Management System Video](https://www.linkedin.com/posts/hussain-ali-0805b8282_attendance-management-system-user-panel-activity-7170530111018975232-QXXv?utm_source=share&utm_medium=member_desktop)  

---
## Features  

### **User Panel**  
- **Registration and Login**:  
  - New users can register and log in to access the system.  

- **Mark Attendance**:  
  - Students can mark their attendance as **present**.  
  - Attendance can only be marked once per day.  
  - Users cannot delete their attendance.  

- **View Attendance**:  
  - Students can view all their marked attendance records.  

- **Leave Request**:  
  - Students can send leave requests to the admin for approval.  

- **Profile Management**:  
  - Edit and update the profile picture.  

---

### **Admin Panel**  
- **Login**:  
  - Admins can log in through a secure login page.  

- **View Records**:  
  - Admins can view all login records of students.  

- **Edit, Add, and Delete Attendance**:  
  - Administrators can manage students' attendance records.  

- **Reports**:  
  - Generate attendance reports for specific users based on a date range (**FROM** and **TO**).  
  - Create a system-wide attendance report for all users.  

- **Leave Approval**:  
  - Review and approve/reject leave requests from students.  
  - Maintain a proper count of **Leaves**, **Presents**, and **Absents** for each student.  

- **Grading System**:  
  - Automatically assign grades based on attendance:  
    - **A Grade**: 26+ days attended.  
    - **D Grade**: Less than 10 days attended.  
  - Fully customizable grading module.  

---

## Known Limitations  

While the app is highly functional, there are a few small imperfections:  
- Performance may be slightly affected when generating large attendance reports for extended date ranges.  
- User interface design could be further refined for an enhanced user experience.  
- **Attendance Dependency on Login**:  
  - If the student does not log in every day, the app cannot register their attendance.  
  - I plan to address this issue by implementing background services in the future, but for now, it remains a limitation.  
- Approving leaves logic is not implemented
---
