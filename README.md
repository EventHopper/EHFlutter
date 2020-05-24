# EventHopper Flutter (EHFlutter)
## This Repository Contains All Relevant EventHopper Web & Mobile App Code

The following tables detail feature specifications and corresponding mockups:

<center>

Messaging Feature             |  Mockup
:-------------------------:|:-------------------------:
Groupchats are created each <br/> time an event is organized |  <img src="docs/Messages.png" alt="drawing" width="200"/>

</center>

### For Developers: 
**Please use ternary operators wherever possible.** <br> Example: <br>
```diff
+ color = selectedGender == Gender.MALE ? activeCardColour : inactiveCardColour

- if (selectedGender == Gender.MALE) {
-   color = activeCardColour;
- } else {
-   color = inactiveCardColour;
- }
```
