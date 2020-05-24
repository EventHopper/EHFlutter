# EHFlutter (EventHopper Flutter)
#### This Repository Contains All Relevant EventHopper Web & Mobile App Code

## Feature Review

The following tables detail feature specifications and corresponding mockups:

<center>

Messaging Feature             |  Mockup
:-------------------------:|:-------------------------:
Groupchats are created each <br/> time an event is organized |  <img src="docs/Messages.png" alt="drawing" width="200"/>

</center>

## Workflow Rules for EHFlutter Developers: 
**1. Always Open an Issue for a Feature**: <br>
This is an important one. To track progress and ensure good project structure, an **issue must be created per feature** within the relevant project. <br><br>
**2. Always Add a Reviewer**: <br>
No code is to be merged into master without review from another developer. A reviewer can be added to a particular commit. **For flutter-related code, add @kylermintah as a reviewer.**<br><br>

## Style Notes for EHFlutter Developers: <br>
Please review and refer to [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) for style consistency.
<br>
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
<em><br><a href="https://dev.to/shreyasminocha/what-do-you-think-about-the-ternary-operator-5ajg" target="_blank">comment on ternary operators</a></em>
</p>
