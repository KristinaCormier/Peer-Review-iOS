🟣 1. MARKDOWN-STYLE STRUCTURE OF OUR REPO:

Peer-Review-iOS/
└── Peerreview/
    ├── Peerreview.xcodeproj/
    ├── Peerreview/
    │   ├── Assets.xcassets/
    │   ├── AdminCoursesView.swift
    │   ├── AssignmentHubView.swift
    │   ├── AssignmentTemplateView.swift
    │   ├── AssignmentView.swift
    │   ├── BrainstormTemplateView.swift
    │   ├── Brainstorming.pdf
    │   ├── CourseCardView.swift
    │   ├── CourseDetailView.swift
    │   ├── CreateAssignmentView.swift
    │   ├── CreateReviewView.swift
    │   ├── ForgotPasswordView.swift
    │   ├── HomeView.swift
    │   ├── LoginView.swift
    │   ├── LoginViewWrapper.swift
    │   ├── ManageProfessorsView.swift
    │   ├── ManageStudentsView.swift
    │   ├── Models.swift
    │   ├── MyReviewsView.swift
    │   ├── PDFDocumentWrapper.swift
    │   ├── PDFViewer.swift
    │   ├── PastAssignmentView.swift
    │   ├── PeerreviewApp.swift
    │   ├── ProfileView.swift
    │   ├── QuickLookPreview.swift
    │   ├── ReviewFormView.swift
    │   ├── ReviewView.swift
    │   ├── SearchView.swift
    │   ├── SidebarView.swift
    │   ├── SplashView.swift
    │   ├── TemplatesView.swift
    │   ├── UpcomingAssignmentView.swift
    │   ├── UploadAssignmentView.swift
    │   ├── UserSession.swift
    │   └── assignment.pdf
    │
    ├── PeerreviewTests/
    └── PeerreviewUITests/

🟣 2. APP FLOW (VERY IMPORTANT)

The app starts with a Splash Screen, then goes to Login Page, and after authentication, the user is taken to the Dashboard.

👉 Back it with structure:

Entry point →
Splash →
Login →
Dashboard →
🟣 3. ROLES SYSTEM

We have implemented a role-based system with three roles:

Student
Professor
Admin

Based on the selected role, the app shows different functionalities like managing students, courses, and templates.

👉 Mention:

Role enum →
🟣 4. MAIN FEATURES (SAY THIS CLEAN)
📌 Dashboard

The dashboard shows courses like COSC 404, 470, and 360, and each course leads to detailed features.

📌 Assignments

Users can:

Upload assignments
View upcoming assignments
View past assignments
Access review system

👉 Code:

Assignment Hub →
📌 Reviews

Users can submit peer reviews with:

Assignment name
Feedback text
Star rating system

👉 Code:

Create Review →
📌 Templates

Templates like brainstorming and assignment formats are available.
Users can download, preview, and upload templates.

👉 Code:

Templates →
📌 Profile

Users can update their profile including:

Name
Email
Phone
Profile image

👉 Code:

Profile →
📌 Admin Features

Admin and professors can:

Manage students
Manage professors
Manage courses

👉 Code:

Manage Students →
Manage Professors →
Courses →
🟣 5. ARCHITECTURE (VERY IMPORTANT PART)

The app is structured using a SwiftUI-based modular architecture.

🔹 Models

We created multiple model classes such as:

UserSession
Student
Professor
Course

👉 Example:

UserSession →
🔹 Views

Each screen is built using SwiftUI struct views, making the UI modular and reusable.

🔹 State Management

We used:

@State → local UI state
@Binding → pass data
@EnvironmentObject → global state
🔹 Navigation

Navigation is implemented using:

NavigationStack
navigationDestination
🟣 6. ANIMATIONS (REQUIREMENT)

We implemented animations in the splash screen using:

scaling effect
glowing effect
delayed transition

👉 Code:

🟣 7. DATABASE (MOST IMPORTANT QUESTION ⚠️)

Say this CONFIDENTLY:

Currently, the app uses local state-based data storage to simulate database functionality.
This allows us to demonstrate full UI interaction.
In future, it can be extended using SwiftData or API integration.

🟣 8. REQUIREMENTS CHECK (FINAL HIT)

Our project satisfies most requirements:

✅ Multiple models
✅ Multiple views
✅ Animations
⚠️ Database simulated using local state
🟣 9. CONCLUSION (END LIKE THIS)

Overall, this application demonstrates a complete peer review system interface, with scalable architecture that can be extended with backend integration.

Thank you.

⚡ BONUS: IF PROF INTERRUPTS
❓ “Where is your database?”

👉

Currently simulated using local state. Designed for easy API integration.

❓ “What is most important class?”

👉

UserSession — it manages global app state.

❓ “How data flows?”

👉

Through @State, @Binding, and EnvironmentObject.


Credit: Mehak Preet
