
# Explanation:
# If Nginx is stopped, it will be automatically restarted and activated. And if it is not activated, the manager will be notified.
# We use SSMTP to send email, have it installed on the server.
# The script checks if Nginx is running using the systemctl is-active command to get the status of the Nginx service.
# If Nginx is not running, the script restarts the service using the systemctl restart command and sends a notification email using the mail command.
# If Nginx is running, the script echoes a message saying that Nginx is running.
# The script starts by setting the email addresses to send the notifications as variables $to_email and $from_email.





#!/bin/bash
# Set the email addresses to send the notifications
to_email="notify@example.com" # The email address to notify if the service goes down
from_email="server@example.com" # The email address to send the notification from

# Check if Nginx is running
nginx_status=$(systemctl is-active nginx)

# If Nginx is not running, restart the service and send a notification
if [ "$nginx_status" != "active" ]; then
  # Restart Nginx
  systemctl restart nginx

  # Log the restart in the nginx-restart.log file
  echo "$(date): Nginx service restarted." >> /var/log/nginx-restart.log

  # Send the notification email
  subject="Nginx Service Restarted"
  body="The Nginx service has been restarted on the server."
  echo -e "From: $from_email\nTo: $to_email\nSubject: $subject\n\n$body" | ssmtp $to_email
else
  # Nginx is running, so everything is fine
  echo "Nginx is running."
fi
