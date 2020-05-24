# EventHopper Flutter (EHFlutter)
## This Repository Contains All Relevant EventHopper Web & Mobile App Code

The following tables detail feature specifications and corresponding mockups:

<center>

Messaging Feature             |  Mockup
:-------------------------:|:-------------------------:
Groupchats are created each <br/> time an event is organized |  <img src="docs/Messages.png" alt="drawing" width="200"/>

</center>

### For EHFlutter Developers: 
**1. Please utilize Ternary Operators wherever possible.** <br> Example: <br>
```diff
+ color = selectedGender == Gender.MALE ? activeCardColour : inactiveCardColour

- if (selectedGender == Gender.MALE) {
-   color = activeCardColour;
- } else {
-   color = inactiveCardColour;
- }
```

>Ternary Operators are great for widget trees and can simplify code. However, please also note that it is important to ensure good formatting to maintain ternary operator code readability:<br>
<p align="center">
<img src="./docs/thecaseforternaryoperator.PNG" alt="drawing" width="600"/>
<em><br><a href="https://dev.to/shreyasminocha/what-do-you-think-about-the-ternary-operator-5ajg">comment on ternary operators</a></em>
</p>
