# So you want to contribute to EventHopper?

### We're happy to have you! :smile:

Contributing is easy. If creating an issue, please refer to the template below in the **Issue** section. Please refer to Flutter best practices detailed in the **Development** section.

## Contributor Types

Please note there are three types of contributers:
- **EventHopper Friends** - _Contribute as you have time!_
- **EvnetHopper Joey** - _Looking to join team, must follow [point system requirements](https://github.com/EventHopper/EHFlutter/blob/beta/CONTRIBUTING.md#point-system)_
- **EventHopper Core** - _follow EventHopper team role requirements_

## Issues

We try our best to keep a logical formatting on our issues. The three most important _**Information Points**_ to include are a **Description** _(thorough description of the issue)_, **Starting Requirements** _(any issues or features that need to be resolved before work can start on this issue - apply own judgement but ask around too)_, **Completion Requirements** _(every task that needs to be completed by one or more PRs in order to close the issue)_

### Issue Template:
The following issue example is from [Issue #33](https://www.github.com/eventhopper/EHFlutter/issues/33)
``` markdown
**Description:**

> Right now, developers are able to toggle between prod and dev (sandbox) environment.
> We need to refactor the sandbox/dev dart class to include logic for switching between the api and dev CNAMEs.
> This is important because we do not want to congest our production server once we initiate deployment.

**Requirements to start:** 
- [x] [**#EHServerSide/159**](https://www.github.com/eventhopper/ehserverside/issues/159)

**Requirements for completion:**
- [ ] sandbox environment must point to `https://dev.eventhopper.app/`
- [ ] prod environment must point to`https://api.eventhopper.app/`

```

In the example above notice how we link to issues in different repositories. Please do this when specifying issues in [**EHServerSide**](https://www.github.com/EventHopper/EHServerSide) or other repos.

### Why the checkboxes? (optional)
Well, after creating an issue with checkboxes in the description, your issue may look something like this:

![picture](https://user-images.githubusercontent.com/24496327/96217210-1dff4100-0f50-11eb-83e0-35ca731b4047.png)

You may have noticed the progress bar underneath the issue title above labeled '1 of 3.'
Whenever you add checkboxes to an issue the progress indicator automatically generates and fills proportionally as each box is checked off. You can use this at your own discretion but it's great to keep track of the **[three requirement information points as mentioned above](https://github.com/EventHopper/EHFlutter/blob/beta/CONTRIBUTING.md#issues)**.


### Point System

This is relevant only **for contributors who would like stake in EventHopper.** All other friends of EventHopper are welcome to contribute as they'd like! The EventHopper team allocates points to each issue. If you would like to be considered eligible for team and stake consideration, you must maintain a net contribution pace of at least 3 points per week for 1 month. After this requirement has been met, the point system is to be adhered to under agreed upon terms with the EventHopper team prior or after joining the core fold. 

<img src="https://user-images.githubusercontent.com/24496327/96217438-9403a800-0f50-11eb-81d5-40e92b256ed8.png" alt="drawing" width="500"/>

## Workflow Rules:

#### **1. Software Release Lifecycle (Version Branches)**: <br>
"Master" sometimes is seen as the branch that is "most official" or up-to-date, however, and from the very beginning, **we will be working on a remote branch per development phase that represents a particular version of the app (i.e. alpha, beta, stable)**. Code review consensus is required for a push to one of the version branches (especially stable - and rigours, automated & manually tested review for stable) as these branches will form the basis of our production code. <br><br>
#### **2. Always Open an Issue for a Feature**: <br>
This is an important one. To track progress and ensure good project structure, an **issue must be created per feature** within the relevant project. <br><br>
#### **3. Always Add a Reviewer Before Merging**: <br>
No code is to be merged into master without review from another developer. A reviewer can be added to a particular commit. **For flutter-related code, add [@kylermintah](https://www.github.com/kylermintah) as a reviewer.**<br><br>
#### **4. Always Work on a Separate Branch per Feature (BPF)**: <br>
Branch Per Feature (BPF) is a commonly used methodology to upkeep Quality Assurance (QA)<br><br>

## Style Notes: <br>
Please review and refer to [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) for style consistency.
<br>
#### **1. Please utilize Ternary Operators wherever possible.** <br> Example: <br>
```diff
+ color = selectedDay.weather == Weather.SUNNY ? gold : blue

- if (selectedDay.weather == Weather.SUNNY) {
-   color = gold;
- } else {
-   color = blue;
- }
```

>Ternary Operators are great for widget trees and can simplify code. However, please also note that it is important to ensure good formatting to maintain ternary operator code readability:<br>
<p align="center">
<img src="docs/thecaseforternaryoperator.PNG" alt="drawing" width="600"/>
<em><br><a href="https://dev.to/shreyasminocha/what-do-you-think-about-the-ternary-operator-5ajg" target="_blank">comment on ternary operators</a></em>
</p>

#### **2. Don't be afraid to use Functions as 1st Order Objects**
<br> Dart allows you to pass functions as objects which can be very useful for custom widgets. Where there is an opportunity to modularize code, and generify functionality of a widget definitely take it within reason! We would like to keep the code as D.R.Y as possible and reuse of generic widgets can be helpful in this regard.

```diff
+  final Function onPress;
```

#### **3. Respect the lib folder (Package layout conventions)** <br>
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
 
 #### **4. Constants.dart file** <br>
 constants.dart is a very important file for ensuring uniformity accross the app. Please note there are some brilliant conventions for style utilized in constants.dart that ensure enhanced productivity. For starters, all const variables in constants.dart must begin with a leading 'k' as so:
  ```
import 'package:flutter/material.dart';

const kBottomContainerHeight = 80.0;
const kActiveCardColour = Color(0xFF1d1e33);
const kInactiveCardColour = Color(0xFF111328);
const kButtonColour = Color(0xFFD01247);
const double kIconSize = 80.0;
const kLabelTextStyle = TextStyle(color: Color(0xFF8D8E98), fontSize: 18);

 ```
 
>**Why do this? Because Dart is Smart!** <br>
>Dart looks for instances of the developer typing 'k' when applying a value to an attribute and automatically populates a list of all constants for you to choose from which can save on time and ensure uniformity accross the app.
<p align="center">
<img src="docs/constants.PNG" width="400"/>
<em><br><a href="" target="_blank">constants appear like magic wherever you need them!</a></em>
</p>

>Funny enough this is referred to as variable prefixing and arose from [Hungarian Notation](https://en.wikipedia.org/wiki/Hungarian_notation). It seems to be [frowned upon in the Dart developer docs](https://dart.dev/guides/language/effective-dart/style#dont-use-prefix-letters), but let's do it anyway because it's really convinient.


## Learning:

Udemy and LinkedIn Learning have great resources for Flutter Development. Recommended course links below:

**[The Complete 2020 Flutter Development Bootcamp with Dart](https://www.udemy.com/course/flutter-bootcamp-with-dart/learn/lecture/14485620#content)**<br>4.7 (15,661 ratings)
55,299 students enrolled

**[LinkedIn Learning Flutter Development](https://www.linkedin.com/learning/search?keywords=flutter)** (Free!)

**[London App Brewery](https://www.appbrewery.co/)**<br>
A great team dishing out a bunch of comprehensive courses on app development (and not just the technical side).

Note: https://www.youtube.com/watch?v=rkgPvXWjSpI

