MediNest – Product Requirements Document (PRD)

Product Type: Offline Android Flutter App
Business Model: One-time APK purchase via Instagram
Target Users: Adults, parents, family caretakers, chronic patients
Core Value: Family medicine management + health record organization in one offline app

1. Product Vision 🎯

MediNest is a professional offline family health tracker that helps users:

manage medicines for multiple family members
receive timely medicine reminders
store prescriptions and reports locally
track daily health metrics
keep emergency health details instantly accessible

The app must feel:

✅ simple
✅ premium
✅ trustworthy
✅ adult-friendly

Important rule:

❌ No login
❌ No authentication
❌ No cloud dependency

All data stored only on device.

2. Core Product Philosophy

User should feel:

"My family's health is organized in one private app."

App should open fast and work without internet.

3. Tech Stack ⚙️
Framework
Flutter (latest stable)
Local Database
Hive

Reason:

lightweight
fast
offline
perfect for APK app
Notifications
flutter_local_notifications
Image Storage
image_picker
path_provider
State Management
Provider
Local File Access
permission_handler
Charts (for health logs)
fl_chart
4. Architecture Structure 🧠
lib/
 ├── models/
 ├── screens/
 ├── widgets/
 ├── providers/
 ├── services/
 ├── utils/
 ├── main.dart
5. Local Data Models 📦
FamilyMember Model

Fields:

id
name
photoPath
age
gender
bloodGroup
allergies
diseases
emergencyContact
Medicine Model

Fields:

id
familyMemberId
medicineName
dosage
note
frequency
reminderTimes
startDate
endDate
beforeAfterMeal
activeStatus
HealthLog Model

Fields:

id
familyMemberId
type (BP / Sugar / Weight / Temp)
value
dateTime
Prescription Model

Fields:

id
familyMemberId
imagePath
title
uploadDate
Appointment Model

Fields:

id
familyMemberId
doctorName
hospitalName
diagnosis
appointmentDate
6. Screen-by-Screen Features 📱
Screen 1: Splash Screen
Purpose

Brand trust.

Elements
MediNest logo
clean animation
tagline:

"Family Health Organized"

Behavior
auto navigate to home after 2 sec
Screen 2: Home Dashboard
Main cards
Today's Medicines
Family Members
Health Logs
Prescriptions
Upcoming Appointments
Top section

Greeting:

"Good Morning"

Medicine Summary
pending medicines
completed medicines
missed medicines
Quick Actions

Buttons:

Add Family Member
Add Medicine
Add Health Log
Screen 3: Family Members List
Features

All profiles visible in cards.

Each card:

photo
name
age
blood group
Actions
tap open profile
add new member
edit member
delete member
Screen 4: Add Family Member
Fields
name
age
gender
blood group
allergies
diseases
emergency contact
photo upload
Validation

Name required.

Screen 5: Family Member Profile
Sections
Basic Info
Active Medicines
Health Logs
Prescriptions
Appointments
Screen 6: Medicines List
Features

Show medicines per member.

Each card:

medicine name
dose
next reminder
meal note
Actions
mark taken
skip
edit
delete
Screen 7: Add Medicine
Fields
medicine name
dosage
notes
before meal / after meal
start date
end date
reminder time
repeat daily/custom days
Multiple reminder times

Morning / afternoon / night.

Screen 8: Reminder Notification System 🔔
Notification text example

"Time for Father's BP medicine"

Actions inside notification
Taken
Skip
Snooze
Screen 9: Today's Medicine Tracker
Show today's timeline

Morning
Afternoon
Night

Status badges
pending
taken
missed
Screen 10: Health Logs
Track:
BP
Sugar
Weight
Temperature
Add entry button
Screen 11: Add Health Log
Fields
select member
metric type
value
date
Screen 12: Health Charts 📈
Graph view

Per member trends.

For example:

BP trend last 7 days.

Screen 13: Prescription Vault
Upload prescription images

Organized by family member.

Card details
title
date
Screen 14: Upload Prescription
Fields
title
image capture/gallery
Screen 15: Doctor Appointments
Store
doctor name
hospital
diagnosis
date
Screen 16: Emergency Card 🚨
Instant visible data
blood group
diseases
allergies
emergency contact
Screen 17: Settings
Options
app theme
notification sound
export backup later (future optional)
7. UX Rules ✨
Design principles
one tap actions
large readable fonts
simple adult-friendly UI
no clutter
8. UI Style Direction 🎨
Colors
white
soft blue
soft green
Feel

medical + premium

9. Notification Logic ⚡

Medicine reminders must:

trigger even if app closed
repeat accurately
survive phone restart
10. Performance Rules

App must:

open under 2 sec
smooth on low-end Android phones
no lag in image loading
11. Future Expansion (not first version)

Possible later:

PDF export
encrypted backup
family share
12. Most Important Product Rule 🚨

User must never feel app complicated.

Every screen should answer:

"What does user need right now?"

13. Recommended First Launch Version (Best for selling fast)

Focus only:

✅ family profiles
✅ medicines
✅ reminders
✅ health logs
✅ prescriptions

Appointments optional later.

14. Best Selling Angle for Instagram 🔥

Sell message:

"A simple private app to manage your family's medicines and health records offline."