# My Simple 21 Day Log
The goal of this project is to create a simple progress tracker for the 21 Day Fix food-portion program. The aim is to build this for the iOS 8.4 platform in Objective-C. You need XCode 7 to build this project.

## Features
- Log
	- Users can keep a daily log of their progress by clicking on the appropriate cup color as referenced in the 21 Day Fix program.
	- The logging is backed by a Realm.io database, which allows users to reference past days.
- Calendar
	- The calendar will provide a simple and usable interface for users to track their monthly progress through the 21 Day Fix program.
	- The days will indicate whether the user met the program goals for that day.
- Settings
	- The settings section of the program will automatically calculate the intended calorie target for the user and suggest recommend goals that relate to the 21 Day Fix program.

## How to use
To use Simple 21 Day Fix Tracker, first set your target calorie by entering your current weight in the Settings section of the program. Doing so will set recommended goals for the program, which is calculated based on the official 21 Day Fix calorie target formula.
Once you have set goals, you may begin logging your daily progress by clicking on the appropriate cup colors. The log is backed by a Realm.io database, which means you will be able to access past logs.

## Work in progress
~~8.31.15 - As of this date, the calendar portion is not implemented.~~

~~9.25.15 - Fully functional calendar and log.~~

9.25.15 - Polish the graphics on the calendar and settings views.

~~9.25.15 - Adapt for other device sizes~~

## Technologies
Simple 21 Day Tracker is built in Objective-C with XCode 7. The program is backed by a Realm.io database.
