//
//  README.md
//  Week2_Assignment
//
//  Created by Rayaheen Mseri on 15/09/1446 AH.
//

# To-Do List App - SwiftUI

## Overview

This To-Do List app is a simple, yet fully functional task management app built using **SwiftUI**. The app features multiple screens, dark mode support, smooth animations, custom theming, and a responsive design that adapts to various screen sizes. The app utilizes **MVVM architecture** with `ObservableObject` for data handling and state management.

### Features:
1. **Multi-Screen Navigation & Data Flow**:
   - Implemented **NavigationStack** for navigating between task list and task details.
   - Utilized **NavigationLink** to open a detailed view for each task.
   - Data is passed between views using `@State`, `@Binding`, and `@ObservedObject`.

2. **Task Management**:
   - **TextField** is used to input task descriptions.
   - Added a button to dynamically add tasks to the list.
   - Tasks are managed using an **ObservableObject** with `@Published` properties to update the task list.

3. **Task Filtering & Color Flagging**:
   - A filter icon is integrated to allow sorting tasks alphabetically.
   - Each task has a customizable color assigned when creating the task, providing better organization and visualization.

4. **UI Theming & Dark Mode Support**:
   - The app follows **Apple’s Human Interface Guidelines** for spacing, typography, and design principles.
   - **Dark mode support** is enabled using `.preferredColorScheme()` for a seamless experience on all devices.

5. **Smooth Animations & Transitions**:
   - Smooth task interactions with **.animation()** to enhance user experience.
   - **.transition()** is applied when adding/removing tasks for a dynamic and fluid user interface.
   - Fade-in effect is added for tasks when they appear.

6. **Dynamic Layouts & Adaptive UI**:
   - **GeometryReader** is used to ensure the app’s UI adapts to different screen sizes and orientations.
   - **LazyVStack** optimizes the display of large lists of tasks.

## UI Inspiration

The user interface of this app was inspired by the **Kavsoft** channel on **YouTube**. The design emphasizes simplicity, smooth transitions, and a modern aesthetic. You can visit the Kavsoft channel [here](https://www.youtube.com/c/Kavsoft).


## Challenges

Some of the challenges faced during the development of this app included:
- Ensuring that the app works seamlessly across different screen sizes using **GeometryReader**.
- Properly implementing the task filtering and sorting feature to be both dynamic and efficient.

## Future Improvements

1. **Data Persistence**: Implementing Core Data or UserDefaults to persist tasks even after the app is closed.
2. **Task Notifications**: Allow users to set reminders or notifications for tasks.
3. **User Authentication**: Adding user accounts to save tasks across devices.

## Conclusion

This To-Do List app demonstrates the power of **SwiftUI** in creating modern, responsive apps with smooth animations, dynamic layouts, and efficient data handling using the **MVVM** architecture. The project was a great exercise in UI design, state management, and working with SwiftUI's tools for building intuitive applications.
