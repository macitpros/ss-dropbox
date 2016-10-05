# ss-dropbox
Applescript to take a screen shot and upload it to a Dropbox account.
This simple Applescript will take a screen shot, save it to the tmp directory then upload to Dropbox. This script was developed for those times a customer/client doesn't have email access (because of an error message on their screen), or the customer is generally challenged when it comes to taking and sending a screen shot.
You'll need the following in order to make this script work. A Dropbox account (I suggest using a standalone account, you'll see why soon). A Dropbox token: https://dropbox.github.io/dropbox-api-v2-explorer/#auth_token/revoke

It is highly suggested that you create and use a separate Dropbox account when using this script. There are 2 main reasons for this.

1. The token is kept in plain text so it can be read and used to read/write to the associated Dropbox account.
2. If something goes wrong, you’ll only screw up your “Screen Shot” Dropbox account.

After you set up the Dropbox account for this to work, simply share the folder where all of the screen shots are going to with your main Dropbox account. This will give you access to them and notify you when new files are added.

Steps:

1. Setup a new Dropbox account. (see below)
2. Get the Dropbox token: https://dropbox.github.io/dropbox-api-v2-explorer/#auth_token/revoke
3. Modify the script with your token.
4. Save the script as an Application.
5. Install the new Application in the Applications folder.
6. Create some easy way for your customer to get at it (Dock, alias, etc…)

Extra tip:

If you want some storage space, before you setup your “Screen Shot” Dropbox account, go to your main Dropbox account and either invite yourself to a new Dropbox account, or grab the link and sign up from there: https://www.dropbox.com/account (under the Account tab).

Say thanks:

If you want to say thank you to me for posting this script, use my referral link instead. Then I’ll can get some extra Dropbox storage: https://db.tt/CBedkPOm
