# macOS Automated Password Change
Ever have that issue when you want to change the global local admin password that is used on basically every computer running OS X (macOS) on your campus. Look no further, this will automate that password change for you with the help of a .pkg file and remote deployment software such as Dell KACE or Apple Remote Desktop (ARD).

To change the password, modify the file <code>postinstall</code> located under <code>/scripts</code>. Open it with a plain text editor or nano via command line.

Format the <code>postinstall</code> parameters as such
<code>dscl . -passwd /Users/< username > < old-pass > < new-pass ></code>
replacing each filler with the actual username, old and new passwords

When you have made your changes, save the file and close it.
In this current directory there is an executable file called build. Run it,
as it will make the new .pkg file that can be ran locally or via KACE or ARD.
