# ss-dropbox
## AppleScript to take a screen shot and upload it to a Dropbox account.
###### This simple AppleScript will take a screen shot, save it to the tmp directory, then upload to Dropbox. This script was developed for those times a customer/client doesn't have email access (because of an error message on their screen), or the customer is generally challenged when it comes to taking and sending a screen shot. The screen shot will be placed in ScreenShots/_SerialNumber_ folder on Dropbox along with a .webloc file for quick access to the corresponding Watchman Monitoring record.
You'll need the following in order to make this script work. A Dropbox account (I suggest using a standalone account, you'll see why soon). A Dropbox token: https://dropbox.github.io/dropbox-api-v2-explorer/#auth_token/revoke

It is highly suggested that you create and use a separate Dropbox account when using this script. There are 2 main reasons for this.

1. The token is kept in plain text so it can be read and used to read/write to the associated Dropbox account.
2. If something goes wrong, you’ll only screw up your “Screen Shot” Dropbox account.

After you set up the Dropbox account for this to work, simply share the folder where all of the screen shots are going to with your main Dropbox account. This will give you access to them and notify you when new files are added.

**Steps:**

1. Setup a new Dropbox account. (see below)
2. Get the Dropbox token: https://dropbox.github.io/dropbox-api-v2-explorer/#auth_token/revoke
3. Modify the script with your token.
4. Save the script as an Application.
5. Install the new Application in the `/Applications` folder. Ensuring it is saved with `root` as the owner will prevent gatekeeper warnings.
6. Create some easy way for your customer to get at it (Watchman Contact menu, Dock, alias, etc…)

**Adding to the Watchman Monitoring Contact Menu**

After you get the Application created and installed, you'll need to get it's unique bundle ID.  Here's how to do it:

1. Open Terminal.app (in Applications/Utilities)
2. Run the following command: `osascript -e 'id of app "YourAppName.app"'` (replace YourAppName.app with the name of your AppleScript App.)
3. Create a new Application menu item in your Watchman Monitoring Contact Menu editor: `https://app.monitoringclient.com/contact-menu/customize` (replace "app" with, your Watchman Monitoring account's subdomain)
4. Choose "Launch Using" as "Apple Bundle Identifier" from the dropdown menu.
5. Enter the unique bundle ID (ie. `com.apple.ScriptEditor.id.screen-shot-script`)
6. Test, test, test!

**Extra tip:**

If you want some storage space, before you setup your “Screen Shot” Dropbox account, go to your main Dropbox account and either invite yourself to a new Dropbox account, or grab the link and sign up from there: https://www.dropbox.com/account (under the Account tab).

**Say thanks:**

If you want to say thank you to me for posting this script, use my referral link instead. Then I can get some extra Dropbox storage: https://db.tt/CBedkPOm

**USE THIS SCRIPT AT YOUR OWN RISK**
