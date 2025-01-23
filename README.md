# rs_code_task
This project addresses the need for efficient application updates within a local network. By leveraging a central admin device, users can download and install compatible APK versions even without internet connectivity.

Problem Statement
	1.	Inconsistent Updates: Users may not always have the latest application version, potentially causing issues.
	2.	Limited Internet Access: Frequent updates can be challenging without consistent internet connectivity.

Objectives
	•	Users send their processor type to the admin phone.
	•	The admin phone sends an APK version compatible with the user’s processor type.
	•	After the download:
	•	The APK version is installed on the user’s device.
	•	The APK is automatically deleted from the user’s device.

Features
	•	UI for Download Progress: Displays download progress percentage (can be in the console).
	•	Multi-User Requests: Supports simultaneous requests from multiple users.
	•	Efficient Version Management: Ensures compatibility by distributing processor-specific APKs.

Requirements
	1.	A WiFi network with a known IP address for the admin device.
	2.	A Flutter-based app with the following functionalities:
	•	User sends processor type.
	•	Admin responds with the appropriate APK.
	•	APK installation and post-installation cleanup.

Implementation Notes
	•	Design any UI for the app, with a focus on displaying the download progress.
	•	Track and display file transfer completion percentages for each user.

Installation & Usage
	1.	Clone this repository:

git clone https://github.com/<your-repo-name>.git
cd <your-repo-name>


	2.	Open the project in your Flutter environment.
	3.	Run the app on your admin device and user devices:

flutter run


	4.	Ensure all devices are connected to the same WiFi network.
	5.	Follow the in-app instructions to send the processor type and download the appropriate APK.

Contributing

Contributions are welcome! Please follow the standard GitHub workflow:
	1.	Fork this repository.
	2.	Create a feature branch.
	3.	Commit your changes.
	4.	Submit a pull request.

License

This project is licensed under the MIT License. See the LICENSE file for details.

Let me know if you need further customization!

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
