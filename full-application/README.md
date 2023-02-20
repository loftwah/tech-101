# WordPress troubleshooting

Our WordPress instance is hosted on WPEngine. These are some troubleshooting steps you can use once your SSH keys are configured.

1. **Connect to your site using SSH:** Log in to your WPEngine account and select your WordPress site. Under the "SSH Gateway" section, click the "SSH Gateway Access" button to open a terminal window.

2. **Navigate to the site's root directory:** In the terminal window, navigate to the root directory of your WordPress site by typing `cd /nas/content/live/<sitename>/`, replacing `<sitename>` with the name of your WordPress site.

3. **Review the error message:** Use the `less` command to view the error log file for your site. The error log file is usually located in the `wp-content` directory and has a name that starts with `debug.log`. For example, you can view the error log file by typing `less wp-content/debug.log`. Look for any additional information in the error message, such as the function or method where the error occurred, or the line number in the code.

4. **Identify the cause of the error:** Based on the error message, review the related code and data to identify the cause of the error. Look for any instances where the "delete" index may be undefined or missing, or where there may be an issue with how data is being accessed or manipulated.

5. **Fix the error:** Once you have identified the cause of the error, make the necessary changes to fix the issue. You can use your preferred text editor, such as `nano` or `vim`, to edit the relevant code file. You may also need to make changes to how data is stored or accessed, such as modifying database queries or updating configuration files.

6. **Test and verify the fix:** After making changes to the code, test your site to ensure that the error has been resolved and that there are no other issues. You can use a web browser to visit your site and test the affected functionality. You can also use the `curl` command to perform tests via the command line.

7. **Monitor your site:** Keep an eye on your site to ensure that the error doesn't reoccur and that there are no other issues with your site's performance or functionality. You can use the `tail` command to monitor the error log file in real-time and look for any new errors or warnings.

That's it! If you're not comfortable with using SSH or troubleshooting errors yourself, it may be a good idea to consult with a developer or support team who can provide further assistance.
