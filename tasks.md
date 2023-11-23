- Date Column ka width chota karden 
- Organise folder struc 
- Parametrize the dimensions, texts, colours. 

--- 

- Issue with keyboard
    - Test on android device 
- Add today's text_1 to the LaunchScreen
- Overflowing Tab3 Input 
- Auto dispose

---

- Keyboard issue 
    - Tab1 comment dialog box should be removed
- Maintain design consistency 
    - Tab3 FABs are not consistent
    - Add a cancel button to tab3 input screen 
- Add the tab3 input screen FAB to tab4 and also home screen FAB 
- Tab3 data to Launch Screen 
- Tab4 latest 5 to Launch Screen 

--- 

- Add numbers of tab 4 to launch screen -D
- tab3 entry not working in launchscreen -D
- Timings idhar udhar ho rahi hain tab3 output men -D
- Date and time should be visible before and after selection, both in tab 3 and tab 4 -D
- Sort the entry to show CURRENT date at the top and the FUTURE date below it. Do not show PAST dates. -D
- The date and number in Tab 3 and Tab 4 output should be in a separate SizedBox / Container to make them clearly visible with proper alignment. -D

---

- Home page. Tab 4 summary looks good, but its not correct in Tab 4 output page. Tab 4 output page should be the same as Home screen summary of Tab 4 
- Home page. Tab 3 summary should look the same as Tab 3 output page, currently it only shows text, it should also show date and time like in Tab 3 output screen.
- Complete parametrization 

---

- Make launch screen cleaner by eliminating repetition and adding strictness.
- Separate tab2, tab3, and tab4 views in the launch screen for better SoC.
- Home screen summary of tab 3 should only show data pertaining to today's date. If not exists, then show nothing. Do not show today's date as it would be understood. -D
- Font of summary of tab3 and tab4 should be identical. -D
- Keyboard type should be relevant to the TextField. For eg., for a text field that only accepts numbers, the keyboard should only have numbers. -D

--- 

- Isolate the updateNextUpdateTime function in a separate FutureProvider. When disposed, cancel the timer. 

---

- Add "Every" to the app. -D
- Make code cleaner. -D
- Last should be -1. Last can be 4 or 5. -D
- Make code DRY.
- Add options: Weekly and Daily.

** Inshaa Allah **

---

- Text 1 should be a text field and should not be showing in a separate dialog. -D
- Repeat not necessary. Can be nullable. Repeats "Never". -D
- Change "Start Date" to "Date", "Start Time" to "Time". -D
- Design consistency. -D
- Change end time to Duration. Two separate buttons. 
- Change sliders to boxes. -D