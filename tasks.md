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

**Inshaa Allah**

---

- Text 1 should be a text field and should not be showing in a separate dialog. -D
- Repeat not necessary. Can be nullable. Repeats "Never". -D
- Change "Start Date" to "Date", "Start Time" to "Time". -D
- Design consistency. -D
- Change end time to Duration. Two separate buttons. 
- Change sliders to boxes. -D

--- 

- Improve spacings -D
- Yearly ka DoW slider should be in the same row -D
- Text1 -> Activity -D
- Output Tab 2
- Add never in dropdown -P
- [Every, Ends] should be nullable -P

--- 

- Test on emulator || actual device 
- Remove the date
- Tab2 is for repeat activities only 
- Date will be calculate at 12 night 
- "tab_2_current_activities.json"

---

- Make code DRY 
- Make providers auto-disposable except repositories
**Inshaa Allah**

---

- Send the number of hours spent -D
- Text field should be mandatory -D
- Time calculation is wrong -D
- Increase spacing for Activity name -D
- Header -D
- Selected tab should be highlighted :: blink -D
- Time should contain AM and PM, should be in 12 hour format -D
- Tab 2 should match with picture -D
- Expand the text field and add a text hint -D
- Duration buttons should be below "Duration", expanded. -D
**Inshaa Allah**

---

- Tab 2 entries should be editable -D
    - Create two functions: 
        - getCurrentActivities
        - writeEditedModel
- Summary of repetitions should be displayed -D
- Calculate the entries based on "every", Yearly.basis.date and end date
- Left aligned -D
- Smaller font size. [-> Tab 2 Output] -D
**Inshaa Allah**

--- 

- Delete entries in tab 2 -D
- Complete CRUD in all the tabs
**Inshaa Allah**

---

- Left -> Right swipe 
- Confirmation dialog before deletion

---

- Keyboard does not disappear after text has been entered -D
- First letter is capital -D
- Text is scrollable. Make it wrappable. -D
- Make tab 1 date editable -D
- Shrink the time cells of tab 2 output. -D
- Improve tab 1 UI 
    - Bold fonts should be replaced; default styling.  -D
    - Replace the radio buttons with cupertino sliders -D
    - Textbox is not user friendly. Add hint text "Today's priority" and border. Should not be full width. -D
- Tab 5 decimal input not coming -D
- Repeats never ko delete karke daily ko default karna hai -D
- Keyboard resizing issue -D
- Tab 3, 4 and 5 suffer from the text overflow issue. -D
- Home screen issues

---

- Tab 1 input screen UI redesign -D
- Tab 1 input FAB does not refresh provider -D
- Keyboard focus problem 
- Tab 2 input screen buttons are so large. Shrink them. -D
- Tab 2 input screen redesign. -D
- Tab 3
    - Redesign -D
    - Activity name should come after -D
    - Date should be floating on top -D
    - Time after the activity -D
- Tab 5 
    - Input redesign 
    - Date choti hai 
    - Text default styling 

---

- Tab 1 Input Screen 
    - Increase spacings between -D
    - Instead of vertical lines, use alternate colours -D

- Tab 2 Input Screen 
    - Repeats description should be italicized -D
    - Duration should be simple -D

- Tab 3 
    - Date should not be like a bouton -D
    - Date and time should be mandatory -D
    - Bug fix -D

- Tab 6 & 7 
    - No duration -D 
    - No end time -D
**Inshaa Allah**

---

- Tab 1 
    - Change row colour || Bahir nikaldo -D
    - No need for time -D
    - Output screen should be like tab 5's -D

- Tab 5 
    - Date should not wrap -D
    - Default text styling -D

- Left align "Activities" header -D 

- Tab 6 and 7 -D
    - Create files for tab 6 and 7
    - Get tab 2, 6, and 7 under one umbrella: *tab_[2, 6, 7]*
    - Have a common repository: *repo.dart*
    - Have CRUD function named *writeTab2Model, etc.* that take in as arguments the file. 
        Then, create separate CRUD functions for each of the that call these basic CRUD functions. 
    - Each tab will have separate output controllers but only **one** input controller.
    - Tab_2 output screen will take in the output controller as a parameter. 
    - Intersections: *repositories, models, input controller, views*.
    - Differences: *output controller*.

**Inshaa Allah**

--- 

- Make tab_2_6_7's output controller code more DRY by using a family provider
- Keyboard issue
- Tab 3 Input -D
    - Redesign 
        - Date        ------------------    DateButton
        - Time        ------------------    TimeButton
        - Priority    ------------------    PriorityPicker
- Tab 5 -D
    - Input Screen Redesign 
    - Date should be editable
- Tab 8 -D
    - Input Screen 
    - Output Screen 

**Inshaa Allah**

---

- Tab 8 -D
    - Design Finalization -D
    - Update -D
    - Delete -D

--- 

- Tab 2 -D
    - Header not needed

- Tab [6, 7] -D
    - Header not needed

- Tab 10 -D
    - Numeric with decimals -D
    - Toggle ke bajaye option -D
    - endToStart swipe -> DialogBox -> isComplete -D
    - Order -D
        - 1. Amount 
        - 2. Text 
        - 3. Date

- Create service for completion :: Tab 10

انشاء اللہ 

--- 

- Side tab buttons should only be displayed on Launch Screen

- Tab 11 
    - "Switch 1" -> "Urgent"

---

- Tab 11 DRYing -D
    - Make the common repo accept a file argument in its constructor
    ?- For $tab, the service would extend the pending repo and it will also implement the markAsComplete function
    [
    - A FutureProvider will fetch the file, pass it to this newly-created service and return it.
        || 
    - The output provider is an AsyncNotifier with the CRUD methods. 
        - This way, we don't a service!!!
    ] 

- Other tabs' DRYness 
    - Move all service and repo methods to controllers. It is the controller's job to manage the state. 
        Otherwise, the code will not be maintable. It is necessary to strike a balance between DRYness and SoC.
    - Use the common repos for **EVERY** tab.
    - 2, 4, 6, 7, 8, 10, 11.

- Efficiency 
    - Time ticker deactivation when not in view.
    - Dispose unnecessary providers.

- Fix tab 1 toJson method and use it to make code DRY. -D

**Inshaa Allah**

---

- [OutputNotifier]s and repositories should be able to infer return type of models. -D

- Tab 2 -D
    - Left align duration 
    - Acivity TFF should be a little more below the appbar.

- Tab 3 -D
    - TTF hint text should be "Activity" 
    - It should be at the top
    - Date should also be deleted if its entries are zero
    - Add completion feature

- Tab 4 -D
    - BUG: Output not refreshed

- Home screen -D
    - Activity left-aligned and time right-aligned

- Tab 5 -D
    - Header names are wrong

- Implemention completion feature in tabs 4 and 5.

- Tab 3, 4 and 5 :: DRYness
    - $tab will create a service provider using the common service notifier.
    - $tab will extend the common output notifier. 
    - $tab's input controller will have syncToDB function while output controller will have delete and complete function.
    - Less code, clean code. Inshaa Allah.

- Use *freezed* for fast and clean model generation.

**Inshaa Allah**

---

**Inshaa Allah**

- Tab 9 I/O screens. -D
- Finish completion feature for all the tabs.
- BUG: Keyboard issue. Keyboards have a done button.
- Tab.[1, 3, 4, 5] have their own services. Therefore, they have their own controllers as well. Can there be a way in which we use the common output controller with a custom service that is also type-safe? 
- Alhamdulillah, now, we do not need any service. The repository is enough itself. Tabs that are similar but not identical can extend the common repository and override methods as needed. 
- Make the DismissibleEntry widget WET.
- Create a compeleted repository for tab 9 to avoid complicated code. 