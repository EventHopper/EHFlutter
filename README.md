# EventHopper Flutter (EHF) <br> 
#### This Repository Contains All Relevant EventHopper Web & Mobile App Code. 
<br> This README file contains relevant information for all EHFlutter Developers and will ensure consistency in development practices towards our feature goals while minimizing breakages.
<br>

## Feature Review

The following tables detail feature specifications and corresponding mockups:

<center>

Messaging Feature             |  Mockup
:-------------------------:|:-------------------------:
Groupchats are created each <br/> time an event is organized |  <img src="docs/Messages.png" alt="drawing" width="200"/>

</center>

# For EHF Developers

<br>

## Releases:

![](docs/releaseExplanation2.png)

At each development phase we will create a release. **What is a release?** A release is simply a neatly packaged **executable form** of the project. In this case, a release will be comprised of a few files - specifically Andriod APK, iOS IPA and WebApp files. These files will represent the project in it's complete form at a given point in the development phase (i.e. alpha, beta, stable, experimental etc.). Read more about releases in the **Version Branches** section of Workflow Rules below.

## Workflow Rules:

**1. Version Branches**: <br>
"Master" sometimes is seen as the branch that is "most official" or up-to-date, however, and from the very beginning, **we will be working on a remote branch per development phase that represent a particular version of the app (i.e. alpha, beta, stable)**. Group consensus is required for a push to one of the version branches as eventually these branches <br><br>
**2. Always Open an Issue for a Feature**: <br>
This is an important one. To track progress and ensure good project structure, an **issue must be created per feature** within the relevant project. <br><br>
**3. Always Add a Reviewer Before Merging**: <br>
No code is to be merged into master without review from another developer. A reviewer can be added to a particular commit. **For flutter-related code, add [@kylermintah](https://www.github.com/kylermintah) as a reviewer.**<br><br>
**4. Always Work on a Separate Branch per Feature (BPF)**: <br>
Branch Per Feature (BPF) is a commonly used methodology to upkeep Quality Assurance (QA)<br><br>

## Style Notes: <br>
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

**2. Don't be afraid to use Functions as 1st Order Objects** <br> Example: <br>
```diff
+  final Function onPress;
```
<br> Dart allows you to pass functions as objects which can be very useful for custom widgets. Where there is an opportunity to modularize code, and generify functionality of a widget definitely take it within reason! We would like to keep the code as D.R.Y as possible and reuse of generic widgets can be helpful in this regard.

**3. Respect the lib folder (Package layout conventions)** <br>
The **lib folder** contains all local dart packages/files and it is important that appropriate structure is maintained. This includes the assets folder and its subfolders, the constants.dart file which dictates constants throughout the app etc. The following is an example of appropriate project folder structure for an project called 'enchilada':

```diff
enchilada/
  .dart_tool/ *
  .packages *
  pubspec.yaml
  pubspec.lock **
  LICENSE
  README.md
  CHANGELOG.md
  benchmark/
    make_lunch.dart
  bin/
    enchilada
  doc/
    api/ ***
    getting_started.md
  example/
    main.dart
  lib/
    enchilada.dart
    tortilla.dart
    guacamole.css
    src/
      beans.dart
      queso.dart
  test/
    enchilada_test.dart
    tortilla_test.dart
  tool/
    generate_docs.dart
  web/
    index.html
    main.dart
    style.css
 ```

 <br> Please note, that while asset folders in dart can have any name (as long as the path is specified in the pubspec.yaml file), **we will put all assets inside of a universal assets folder**. Subsequent subdirectories can be named at the discretion of the developer. The reason for the universal subfolder is so that all assets can be dictated in the pubspec.yaml file with the simple path '/assets.' This will keep the pubspec.yaml file as clean and efficient as possible. For more on Package layout conventions see the [dart developer docs](https://dart.dev/tools/pub/package-layout).
