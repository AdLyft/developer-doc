
# AdLyft Web Portal Guide

This section details the use of the AdLyft web portal for a publisher / developer
looking to integrate a new application into AdLyft.

## Contents

- [Creating a new Application]()
- [Creating a Reward]()

## Creating a new Application

To create a publishing application click the "Create App" button located under
the AdLyft logo in the publisher section of the AdLyft web application.

![Portal Create App Button](/images/portal/create-app-button.png)

This will bring up a modal to enter the details for the new publishing app.

![Portal Create App Modal](/images/portal/create-app-modal.png)

Once you have entered at least a name for the new application you may click
create. This will create a new application in the AdLyft system and
auto-generate a new GID (key) and secret as shown here :

![Portal Newly Created App](/images/portal/new-app.png)

**Note :** The GID and secret shown here has been removed and will not work.

## Creating a Reward

Rewards are what the user completes interactions to earn. These rewards can be
either :

- Consumable
- Non-Consumable

For more information on rewards see the rewards documentation here :
https://github.com/AdLyft/developer-doc/blob/master/doc/rewards.md

Rewards are created by clicking the **Create Reward** button located in the top
right of the campaign details view.

![Create Reward Button](/images/portal/create-reward-button.png)

This will then open a modal

![Create Reward Modal](/images/portal/create-reward-modal.png)

All of the fields are currently required and **the cost or ratio must be greater
than 0**.

The key is what is used in your application to trigger AdLyft to open on a view.
Once created it can not be changed. All other fields can be updated.
