# So you want to contribute to EventHopper?

### We're happy to have you! :smile:

Contributing is easy. If creating an issue, please refer to the template below in the **Issue** section. Please refer to Flutter best practices detailed in the **Development** section.

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

### Why the checkboxes? (optional)
Well, after creating an issue with checkboxes in the description, your issue may look something like this:

![picture](https://user-images.githubusercontent.com/24496327/96217210-1dff4100-0f50-11eb-83e0-35ca731b4047.png)

You may have noticed the progress bar underneath the issue title above labeled '1 of 3.'
Whenever you add checkboxes to an issue the progress indicator automatically generates and fills proportionally as each box is checked off. You can use this at your own discretion but it's great to keep track of the **[three requirement information points as mentioned above](https://github.com/EventHopper/EHFlutter/blob/beta/CONTRIBUTING.md#issues)**.


### Point System

This is relevant only **for contributors who would like stake in EventHopper.** All other friends of EventHopper are welcome to contribute as they'd like! The EventHopper team allocates points to each issue. If you would like to be considered eligible for team and stake consideration, you must maintain a net contribution pace of at least 3 points per week for 1 month. After this requirement has been met, the point system is to be adhered to under agreed upon terms with the EventHopper team prior or after joining the core fold. 

<img src="https://user-images.githubusercontent.com/24496327/96217438-9403a800-0f50-11eb-81d5-40e92b256ed8.png" alt="drawing" width="500"/>
