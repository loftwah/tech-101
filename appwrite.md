Manual (using docker-compose.yml)
For advanced Docker users, the manual installation might seem more familiar. To set up Appwrite manually, download the Appwrite base docker-compose.yml and .env files, then move them inside a directory named appwrite. After the download completes, update the different environment variables as you wish in the .env file and start the Appwrite stack using the following Docker command:

docker compose up -d --remove-orphans
Click Here to Copy
Once the Docker installation completes, go to your machine's hostname or IP address on your browser to access the Appwrite console. Please note that on hosts that are not Linux-native, the server might take a few minutes to start after installation completes.

Stop
You can stop your Appwrite containers by using the following command executed from the same directory as your docker-compose.yml file.

docker compose stop
Click Here to Copy
Uninstall
To stop and remove your Appwrite containers, you can use the following command executed from the same directory as your docker-compose.yml file.

docker compose down -v

Production
Appwrite default setup is designed to help you get started quickly with using the Appwrite server. To run Appwrite successfully in a production environment, you should follow a few basic concepts and best practices. This document assumes you have some very basic understanding of Docker and Docker Compose command-line tools.

Encryption
By default, the Appwrite setup doesn't come with a uniquely generated encryption key. This key is used to store your files and sensitive data like webhook passwords or API keys in a safe way. To take advantage of this feature, you must generate a unique key and set it as the value of the _APP_OPENSSL_KEY_V1 environment variable.

Make sure to keep this key in a safe place and never make it publicly accessible. There are many online resources with methods of keeping your secret keys safe in your servers.

Best Practice
You should always prefer https over http in production environments. This keeps your APIs secure and prevents any redirects from interfering with your requests.

Limit Console Access
By default, anyone can signup for your Appwrite server, create projects, and use your computing power. While this is great for testing around or running your Appwrite service in a network isolated environment, it is highly not recommended for public production use.

We are providing three different methods to limit access to your Appwrite console. You can either set a list of IPs or email address which users are allowed to signup from. You can choose one or multiple restriction methods to apply.

Scaling
Appwrite was built with scalability in mind. Appwrite can scale both horizontally and vertically.

Appwrite uses a few containers to run, where each container has its job. Most of the Appwrite containers are stateless, and in order to scale them, all you need is to replicate them and setup a load balancer to distribute their load.

If you decide to set up a load balancer for a specific container, make sure that the containers that are trying to communicate with it are accessing it through a load balancer and not directly. All connections between Appwrite different containers are set using Docker environment variables.

There are three Appwrite containers that do keep their state. MariaDB, Redis, and InfluxDB containers are used for storing data, cache and pub/sub messaging, and usage stats (in this order). To scale them out, all you need to do is set up a standard cluster (same as you would with any other app using these technologies) according to your needs and performance.

Emails
Sending emails is hard. There are a lot of SPAM rules and configurations to master in order to set a functional SMTP server. The SMTP server that comes packaged with Appwrite is great for development but needs some work done to function well against SPAM filters.

Another easier option is to use an 'SMTP as a service' product like Sendgrid or Mailgun. You can change Appwrite SMTP settings and credentials to any 3rd party provider you like who support SMTP integration using our Docker environment variables. Most SMTP providers offer a decent free tier to get started with.

Backups
Backups are highly recommended for any production environment. Currently, there is no built-in script we provide to do this automatically. To be able to backup your Appwrite server data, stats, and files, you will need to do the following.

Create a script to backups and restore your MariaDB Appwrite schema. Note that trying to backup MariaDB using a docker volume backup can result in a corrupted copy of your data. It is recommended to use MariaDB or MySQL built-in tools for this.
Create a script to backups and restore your InfluxDB stats. If you don't care much about your server stats, you can skip this.
Create a script to backup Appwrite storage volume. There are many online resources explaining different ways to backup a docker volume. When running on multiple servers, it is very recommended to use an attachable storage point. Some cloud providers offer integrated backups to such attachable mount like GCP, AWS, DigitalOcean, and the list continues.
Error Reporting
By default, your Appwrite installation comes with error reporting turned off. You can turn it on in dev mode to try and debug issues or report problems.

In production, it is highly recommended to turn error reporting off. To do so, make sure the Appwrite container environment variable _APP_ENV value from is set to production and not development.

Environment Variables
Appwrite environment variables allow you to edit your server setup configuration and customize it. You can easily change the environment variables by changing them when running Appwrite using Docker CLI or Docker Compose.

Updating your Appwrite environment variables requires you to edit your Appwrite .env file. Your Docker files should be located inside the "appwrite" folder at the location where you first run the Appwrite installation script. It's recommended to use the .env file as a central point for updating your Appwrite configuration rather than changing them directly in your docker-compose.yml file.

After editing your docker-compose.yml or .env files, you will need to recreate your Appwrite stack by running the following compose command in your terminal:

docker compose up -d
Click Here to Copy
You can verify if the changes have been successfully applied by running this command:

docker compose exec appwrite vars
Click Here to Copy
All Options:

 General
 Redis
 MariaDB
 InfluxDB
 StatsD
 SMTP
 Phone
 Storage
 Functions
 Maintenance
 GraphQL
General
Name	Description
_APP_ENV	
Set your server running environment. By default, the var is set to 'development'. When deploying to production, change it to: 'production'.

_APP_LOCALE	
Set your Appwrite's locale. By default, the locale is set to 'en'.

_APP_OPTIONS_ABUSE	
Allows you to disable abuse checks and API rate limiting. By default, set to 'enabled'. To cancel the abuse checking, set to 'disabled'. It is not recommended to disable this check-in a production environment.

_APP_OPTIONS_FORCE_HTTPS	
Allows you to force HTTPS connection to your API. This feature redirects any HTTP call to HTTPS and adds the 'Strict-Transport-Security' header to all HTTP responses. By default, set to 'enabled'. To disable, set to 'disabled'. This feature will work only when your ports are set to default 80 and 443.

_APP_OPENSSL_KEY_V1	
This is your server private secret key that is used to encrypt all sensitive data on your server. Appwrite server encrypts all secret data on your server like webhooks, HTTP passwords, user sessions, and storage files. The var is not set by default, if you wish to take advantage of Appwrite encryption capabilities you should change it and make sure to keep it a secret and have a backup for it.

_APP_DOMAIN	
Your Appwrite domain address. When setting a public suffix domain, Appwrite will attempt to issue a valid SSL certificate automatically. When used with a dev domain, Appwrite will assign a self-signed SSL certificate. The default value is 'localhost'.

_APP_DOMAIN_TARGET	
A DNS A record hostname to serve as a CNAME target for your Appwrite custom domains. You can use the same value as used for the Appwrite '_APP_DOMAIN' variable. The default value is 'localhost'.

_APP_CONSOLE_WHITELIST_ROOT
version >= 0.8.0

This option allows you to disable the creation of new users on the Appwrite console. When enabled only 1 user will be able to use the registration form. New users can be added by inviting them to your project. By default this option is enabled.

_APP_CONSOLE_WHITELIST_EMAILS	
This option allows you to limit creation of new users on the Appwrite console. This option is very useful for small teams or sole developers. To enable it, pass a list of allowed email addresses separated by a comma.

_APP_CONSOLE_WHITELIST_IPS	
This last option allows you to limit creation of users in Appwrite console for users sharing the same set of IP addresses. This option is very useful for team working with a VPN service or a company IP.

To enable/activate this option, pass a list of allowed IP addresses separated by a comma.

_APP_SYSTEM_EMAIL_NAME
version >= 0.7.0

This is the sender name value that will appear on email messages sent to developers from the Appwrite console. The default value is: 'Appwrite'. You can use url encoded strings for spaces and special chars.

_APP_SYSTEM_EMAIL_ADDRESS
version >= 0.7.0

This is the sender email address that will appear on email messages sent to developers from the Appwrite console. The default value is 'team@appwrite.io'. You should choose an email address that is allowed to be used from your SMTP server to avoid the server email ending in the users' SPAM folders.

_APP_SYSTEM_RESPONSE_FORMAT
version >= 0.7.0

Use this environment variable to set the default Appwrite HTTP response format to support an older version of Appwrite. This option is useful to overcome breaking changes between versions. You can also use the X-Appwrite-Response-Format HTTP request header to overwrite the response for a specific request. This variable accepts any valid Appwrite version. To use the current version format, leave the value of the variable empty.

_APP_SYSTEM_SECURITY_EMAIL_ADDRESS
version >= 0.7.0

This is the email address used to issue SSL certificates for custom domains or the user agent in your webhooks payload.

_APP_USAGE_STATS
version >= 0.7.0

This variable allows you to disable the collection and displaying of usage stats. This value is set to 'enabled' by default, to disable the usage stats set the value to 'disabled'. When disabled, it's recommended to turn off the Worker Usage, Influxdb and Telegraf containers for better resource usage.

_APP_LOGGING_PROVIDER
version >= 0.12.0

This variable allows you to enable logging errors to 3rd party providers. This value is empty by default, to enable the logger set the value to one of 'sentry', 'raygun', 'appsignal', 'logowl'

_APP_LOGGING_CONFIG
version >= 0.12.0

This variable configures authentication to 3rd party error logging providers. If using Sentry, this should be 'SENTRY_API_KEY;SENTRY_APP_ID'. If using Raygun, this should be Raygun API key. If using AppSignal, this should be AppSignal API key. If using LogOwl, this should be LogOwl Service Ticket.

_APP_USAGE_AGGREGATION_INTERVAL
version >= 1.1.0

Interval value containing the number of seconds that the Appwrite usage process should wait before aggregating stats and syncing it to Database from TimeSeries data. The default value is 30 seconds. Reintroduced in 1.1.0.

_APP_USAGE_TIMESERIES_INTERVAL
version >= 1.0.0

Deprecated since 1.1.0 use _APP_USAGE_AGGREGATION_INTERVAL instead.

_APP_USAGE_DATABASE_INTERVAL
version >= 1.0.0

Deprecated since 1.1.0 use _APP_USAGE_AGGREGATION_INTERVAL instead.

_APP_WORKER_PER_CORE
version >= 0.13.0

Internal Worker per core for the API, Realtime and Executor containers. Can be configured to optimize performance.

Redis
Appwrite uses a Redis server for managing cache, queues and scheduled tasks. The Redis env vars are used to allow Appwrite server to connect to the Redis container.

Name	Description
_APP_REDIS_HOST	
Redis server hostname address. Default value is: 'redis'.

_APP_REDIS_PORT	
Redis server TCP port. Default value is: '6379'.

_APP_REDIS_USER
version >= 0.7

Redis server user. This is an optional variable. Default value is an empty string.

_APP_REDIS_PASS
version >= 0.7

Redis server password. This is an optional variable. Default value is an empty string.

MariaDB
Appwrite is using a MariaDB server for managing persistent database data. The MariaDB env vars are used to allow Appwrite server to connect to the MariaDB container.

Name	Description
_APP_DB_HOST	
MariaDB server host name address. Default value is: 'mariadb'.

_APP_DB_PORT	
MariaDB server TCP port. Default value is: '3306'.

_APP_DB_SCHEMA	
MariaDB server database schema. Default value is: 'appwrite'.

_APP_DB_USER	
MariaDB server user name. Default value is: 'user'.

_APP_DB_PASS	
MariaDB server user password. Default value is: 'password'.

_APP_DB_ROOT_PASS	
MariaDB server root password. Default value is: 'rootsecretpassword'.

InfluxDB
Appwrite uses an InfluxDB server for managing time-series data and server stats. The InfluxDB env vars are used to allow Appwrite server to connect to the InfluxDB container.

Name	Description
_APP_INFLUXDB_HOST	
InfluxDB server host name address. Default value is: 'influxdb'.

_APP_INFLUXDB_PORT	
InfluxDB server TCP port. Default value is: '8086'.

StatsD
Appwrite uses a StatsD server for aggregating and sending stats data over a fast UDP connection. The StatsD env vars are used to allow Appwrite server to connect to the StatsD container.

Name	Description
_APP_STATSD_HOST	
StatsD server host name address. Default value is: 'telegraf'.

_APP_STATSD_PORT	
StatsD server TCP port. Default value is: '8125'.

SMTP
Appwrite is using an SMTP server for emailing your projects users and server admins. The SMTP env vars are used to allow Appwrite server to connect to the SMTP container.

If running in production, it might be easier to use a 3rd party SMTP server as it might be a little more difficult to set up a production SMTP server that will not send all your emails into your user\'s SPAM folder.

Name	Description
_APP_SMTP_HOST	
SMTP server host name address. Use an empty string to disable all mail sending from the server. The default value for this variable is an empty string

_APP_SMTP_PORT	
SMTP server TCP port. Empty by default.

_APP_SMTP_SECURE	
SMTP secure connection protocol. Empty by default, change to 'tls' if running on a secure connection.

_APP_SMTP_USERNAME	
SMTP server user name. Empty by default.

_APP_SMTP_PASSWORD	
SMTP server user password. Empty by default.

Phone
Name	Description
_APP_SMS_PROVIDER
version >= 0.15.0

Provider used for delivering SMS for Phone authentication. Use the following format: 'sms://[USER]:[SECRET]@[PROVIDER]'.

Available providers are twilio, text-magic, telesign, msg91, and vonage.

_APP_SMS_FROM
version >= 0.15.0

Phone number used for sending out messages. Must start with a leading '+' and maximum of 15 digits without spaces (+123456789).

Storage
Name	Description
_APP_STORAGE_LIMIT
version >= 0.7.0

Maximum file size allowed for file upload. The default value is 30MB. You should pass your size limit value in bytes.

_APP_STORAGE_PREVIEW_LIMIT
version >= 0.13.4

Maximum file size allowed for file image preview. The default value is 20MB. You should pass your size limit value in bytes.

_APP_STORAGE_ANTIVIRUS	
This variable allows you to disable the internal anti-virus scans. This value is set to 'disabled' by default, to enable the scans set the value to 'enabled'. Before enabling, you must add the ClamAV service and depend on it on main Appwrite service.

_APP_STORAGE_ANTIVIRUS_HOST
version >= 0.7.0

ClamAV server host name address. Default value is: 'clamav'.

_APP_STORAGE_ANTIVIRUS_PORT
version >= 0.7.0

ClamAV server TCP port. Default value is: '3310'.

_APP_STORAGE_DEVICE
version >= 0.13.0

Select default storage device. The default value is 'local'. List of supported adapters are 'local', 's3', 'dospaces', 'backblaze', 'linode' and 'wasabi'.

_APP_STORAGE_S3_ACCESS_KEY
version >= 0.13.0

AWS S3 storage access key. Required when the storage adapter is set to S3. You can get your access key from your AWS console

_APP_STORAGE_S3_SECRET
version >= 0.13.0

AWS S3 storage secret key. Required when the storage adapter is set to S3. You can get your secret key from your AWS console.

_APP_STORAGE_S3_REGION
version >= 0.13.0

AWS S3 storage region. Required when storage adapter is set to S3. You can find your region info for your bucket from AWS console.

_APP_STORAGE_S3_BUCKET
version >= 0.13.0

AWS S3 storage bucket. Required when storage adapter is set to S3. You can create buckets in your AWS console.

_APP_STORAGE_DO_SPACES_ACCESS_KEY
version >= 0.13.0

DigitalOcean spaces access key. Required when the storage adapter is set to DOSpaces. You can get your access key from your DigitalOcean console.

_APP_STORAGE_DO_SPACES_SECRET
version >= 0.13.0

DigitalOcean spaces secret key. Required when the storage adapter is set to DOSpaces. You can get your secret key from your DigitalOcean console.

_APP_STORAGE_DO_SPACES_REGION
version >= 0.13.0

DigitalOcean spaces region. Required when storage adapter is set to DOSpaces. You can find your region info for your space from DigitalOcean console.

_APP_STORAGE_DO_SPACES_BUCKET
version >= 0.13.0

DigitalOcean spaces bucket. Required when storage adapter is set to DOSpaces. You can create spaces in your DigitalOcean console.

_APP_STORAGE_BACKBLAZE_ACCESS_KEY
version >= 0.14.2

Backblaze access key. Required when the storage adapter is set to Backblaze. Your Backblaze keyID will be your access key. You can get your keyID from your Backblaze console.

_APP_STORAGE_BACKBLAZE_SECRET
version >= 0.14.2

Backblaze secret key. Required when the storage adapter is set to Backblaze. Your Backblaze applicationKey will be your secret key. You can get your applicationKey from your Backblaze console.

_APP_STORAGE_BACKBLAZE_REGION
version >= 0.14.2

Backblaze region. Required when storage adapter is set to Backblaze. You can find your region info from your Backblaze console.

_APP_STORAGE_BACKBLAZE_BUCKET
version >= 0.14.2

Backblaze bucket. Required when storage adapter is set to Backblaze. You can create your bucket from your Backblaze console.

_APP_STORAGE_LINODE_ACCESS_KEY
version >= 0.14.2

Linode object storage access key. Required when the storage adapter is set to Linode. You can get your access key from your Linode console.

_APP_STORAGE_LINODE_SECRET
version >= 0.14.2

Linode object storage secret key. Required when the storage adapter is set to Linode. You can get your secret key from your Linode console.

_APP_STORAGE_LINODE_REGION
version >= 0.14.2

Linode object storage region. Required when storage adapter is set to Linode. You can find your region info from your Linode console.

_APP_STORAGE_LINODE_BUCKET
version >= 0.14.2

Linode object storage bucket. Required when storage adapter is set to Linode. You can create buckets in your Linode console.

_APP_STORAGE_WASABI_ACCESS_KEY
version >= 0.14.2

Wasabi access key. Required when the storage adapter is set to Wasabi. You can get your access key from your Wasabi console.

_APP_STORAGE_WASABI_SECRET
version >= 0.14.2

Wasabi secret key. Required when the storage adapter is set to Wasabi. You can get your secret key from your Wasabi console.

_APP_STORAGE_WASABI_REGION
version >= 0.14.2

Wasabi region. Required when storage adapter is set to Wasabi. You can find your region info from your Wasabi console.

_APP_STORAGE_WASABI_BUCKET
version >= 0.14.2

Wasabi bucket. Required when storage adapter is set to Wasabi. You can create buckets in your Wasabi console.

Functions
Name	Description
_APP_FUNCTIONS_SIZE_LIMIT
version >= 0.13.0

The maximum size deployment in bytes. The default value is 30MB.

_APP_FUNCTIONS_TIMEOUT
version >= 0.7.0

The maximum number of seconds allowed as a timeout value when creating a new function. The default value is 900 seconds. This is the global limit, timeout for individual functions are configured in the function's settings or in appwrite.json.

_APP_FUNCTIONS_BUILD_TIMEOUT
version >= 0.13.0

The maximum number of seconds allowed as a timeout value when building a new function. The default value is 900 seconds.

_APP_FUNCTIONS_CONTAINERS
version >= 0.7.0

The maximum number of containers Appwrite is allowed to keep alive in the background for function environments. Running containers allow faster execution time as there is no need to recreate each container every time a function gets executed. The default value is 10.

_APP_FUNCTIONS_CPUS
version >= 0.7.0

The maximum number of CPU core a single cloud function is allowed to use. Please note that setting a value higher than available cores will result in a function error, which might result in an error. The default value is empty. When it's empty, CPU limit will be disabled.

_APP_FUNCTIONS_MEMORY
version >= 0.7.0

The maximum amount of memory a single cloud function is allowed to use in megabytes. The default value is empty. When it's empty, memory limit will be disabled.

_APP_FUNCTIONS_MEMORY_SWAP
version >= 0.7.0

The maximum amount of swap memory a single cloud function is allowed to use in megabytes. The default value is empty. When it's empty, swap memory limit will be disabled.

_APP_FUNCTIONS_RUNTIMES
version >= 0.8.0

This option allows you to enable or disable runtime environments for cloud functions. Disable unused runtimes to save disk space.

To enable cloud function runtimes, pass a list of enabled environments separated by a comma.

Currently, supported environments are: node-14.5, node-16.0, node-18.0, php-8.0, php-8.1, ruby-3.0, ruby-3.1, python-3.8, python-3.9, python-3.10, deno-1.21, deno-1.24, dart-2.15, dart-2.16, dart-2.17, dotnet-3.1, dotnet-6.0, java-8.0, java-11.0, java-17.0, java-18.0, swift-5.5, kotlin-1.6, cpp-17.0

_APP_EXECUTOR_SECRET
version >= 0.13.0

The secret key used by Appwrite to communicate with the function executor. Make sure to change this!

_APP_EXECUTOR_HOST
version >= 0.13.0

The host used by Appwrite to communicate with the function executor!

_APP_EXECUTOR_RUNTIME_NETWORK
version >= 0.13.0

Deprecated with 0.14.0, use 'OPEN_RUNTIMES_NETWORK' instead!

_APP_FUNCTIONS_ENVS
version >= 0.7.0

Deprecated with 0.8.0, use '_APP_FUNCTIONS_RUNTIMES' instead!

_APP_FUNCTIONS_INACTIVE_THRESHOLD
version >= 0.13.0

The minimum time a function can be inactive before it's container is shutdown and put to sleep. The default value is 60 seconds

DOCKERHUB_PULL_USERNAME
version >= 0.10.0

The username for hub.docker.com. This variable is used to pull images from hub.docker.com.

DOCKERHUB_PULL_PASSWORD
version >= 0.10.0

The password for hub.docker.com. This variable is used to pull images from hub.docker.com.

DOCKERHUB_PULL_EMAIL
version >= 0.10.0

The email for hub.docker.com. This variable is used to pull images from hub.docker.com.

OPEN_RUNTIMES_NETWORK
version >= 0.13.0

The docker network used for communication between the executor and runtimes. Change this if you have altered the default network names.

Maintenance
Name	Description
_APP_MAINTENANCE_INTERVAL
version >= 0.7.0

Interval value containing the number of seconds that the Appwrite maintenance process should wait before executing system cleanups and optimizations. The default value is 86400 seconds (1 day).

_APP_MAINTENANCE_RETENTION_CACHE
version >= 1.0.0

The maximum duration (in seconds) upto which to retain cached files. The default value is 2592000 seconds (30 days).

_APP_MAINTENANCE_RETENTION_EXECUTION
version >= 0.7.0

The maximum duration (in seconds) upto which to retain execution logs. The default value is 1209600 seconds (14 days).

_APP_MAINTENANCE_RETENTION_AUDIT
version >= 0.7.0

IThe maximum duration (in seconds) upto which to retain audit logs. The default value is 1209600 seconds (14 days).

_APP_MAINTENANCE_RETENTION_ABUSE
version >= 0.7.0

The maximum duration (in seconds) upto which to retain abuse logs. The default value is 86400 seconds (1 day).

_APP_MAINTENANCE_RETENTION_USAGE_HOURLY	
The maximum duration (in seconds) upto which to retain hourly usage metrics. The default value is 8640000 seconds (100 days).

GraphQL
Name	Description
_APP_GRAPHQL_MAX_BATCH_SIZE
version >= 1.2.0

Maximum number of batched queries per request. The default value is 10.

_APP_GRAPHQL_MAX_COMPLEXITY
version >= 1.2.0

Maximum complexity of a GraphQL query. One field adds one to query complexity. Lists multiply the complexity by the number of items requested. The default value is 250.

_APP_GRAPHQL_MAX_DEPTH
version >= 1.2.0

Maximum depth of a GraphQL query. One nested field level adds one to query depth. The default value is 3.

Email Delivery
Appwrite v0.7 and above come with support for easy integrations with 3rd party SMTP providers. In order for emails to work, you will need to setup proper SMTP configuration as described below.

Because email deliverability can be both tricky and hard, it is often easier to delegate this responsibility to a 3rd-party SMTP provider. These providers help you abstract the complexity of passing SPAM filters by doing a lot of the advanced configuration and validation for you.

In this document, you will learn how to connect a 3rd party SMTP provider like MailGun or SendGrid with Appwrite to help you get better email deliverability.

Update Your .env File
At this stage, we assume that you have already installed Appwrite. Else, you can follow our Getting Started Guide for the installation. Appwrite offers multiple environment variables to customize your server setup to your needs. To configure Appwrite to use your own SMTP server, you need to set the following environment variables in the hidden .env file that comes with your Appwrite installation.

_APP_SMTP_HOST - SMTP server host name address. Use an empty string to disable all mail sending from the server. The default value for this variable is an empty string

_APP_SMTP_PORT - SMTP server TCP port. Empty by default.

_APP_SMTP_SECURE - SMTP secure connection protocol. Empty by default, change to 'tls' if running on a secure connection. Valid values are empty, 'tls', and 'ssl'.

_APP_SMTP_USERNAME - SMTP server user name. Empty by default.

_APP_SMTP_PASSWORD - SMTP server user password. Empty by default.

_APP_SYSTEM_EMAIL_ADDRESS - Configured sender email address, "team@appwrite.io" by default. This is the email address seen by recipients.

Here's a sample configuration if you're using SendGrid as your SMTP provider.

_APP_SMTP_HOST=smtp.sendgrid.net
_APP_SMTP_PORT=587
_APP_SMTP_SECURE=tls
_APP_SMTP_USERNAME=YOUR-SMTP-USERNAME
_APP_SMTP_PASSWORD=YOUR-SMTP-PASSWORD
_APP_SYSTEM_EMAIL_ADDRESS=YOUR-SENDER-EMAIL
Click Here to Copy
Restart Your Appwrite Server
Once you've updated your .env file, you need to restart your Appwrite instance. Navigate to the directory containing the docker-compose.yml file of your Appwrite instance and run the following command from your terminal:

docker compose up -d
Click Here to Copy
Debugging
If you are unable to send emails, there is most likely an issue with your integration. The first place to look for possible errors is the Appwrite Emails Worker. You can access the logs of this container using:

docker compose logs -f appwrite-worker-mails
Click Here to Copy
The next possible source of error is the configuration in your .env file. Make sure that the keys and values are correct and test the credentials by sending a test email using your SMTP providers' SDK or cURL requests.

Moving on to the next source of error. Some SMTP providers have a concept of authorized recipients in their sandbox (or dev) environments and you can only send emails to recipients in this list. Make sure that the recipient of the email that you're trying to send is a part of this list.

Another source of error could be that the environment variables have not been set in the appwrite container. You can check this using

docker compose exec appwrite-worker-mails vars
Click Here to Copy
If this is the case, you can try rebuilding your appwrite stack using:

docker compose up -d --build --force-recreate
Click Here to Copy
Now you can head over to your Appwrite console, logout from your account and try to recover your password or send invites to other team members from your Appwrite console using your newly configured SMTP provider.

SMS Delivery
Appwrite supports phone authentication, which allows users to create accounts and log in using SMS messages. Appwrite requires an SMS provider to be setup before using Phone authentication.

SMS Providers
Appwrite supports a growing list of SMS providers that you can choose from. Choose one from the list below and set up an account.

SMS Provider	Create Account	Get Credentials
Logo	Twilio	Website	Documentation
Logo	TextMagic	Website	Documentation
Logo	Telesign	Website	Documentation
Logo	MSG91	Website	Documentation
Logo	Vonage	Website	Documentation
Update Your .env File
You will need to configure these environment variables and restart your Appwrite containers before you can use phone authentication.

Provider	_APP_SMS_PROVIDER	_APP_SMS_FROM
Twilio	sms://[ACCOUNT SID]:[AUTH TOKEN]@twilio	[TWILIO PHONE NUMBER]
TextMagic	sms://[USERNAME]:[API KEY]@text-magic	[PHONE NUMBER OR SENDER ID]
TeleSign	sms://[CUSTOMER ID]:[API KEY]:telesign	[TELESIGN PHONE NUMBER]
MSG91	sms://[SENDER ID]:[AUTH KEY]@MSG91	[FLOW ID]
Vonage	sms://[API KEY]:[API SECRET]@vonage	[PHONE NUMBER OR BRAND NAME]
Restart Your Appwrite Server
Once you've updated your .env file, you need to restart your Appwrite instance. Navigate to the directory containing the docker-compose.yml file of your Appwrite instance and run the following command from your terminal:

docker compose up -d
Click Here to Copy
You can verify if the environment variables have changed by running this command:

docker compose exec appwrite-worker-messaging vars

Certificates
Appwrite uses Let's Encrypt to auto-generate TLS certificates for your Appwrite instance to ensure your API traffic is appropriately encrypted. For Appwrite to properly generate certificates, a few conditions need to be met.

You need to use a public-facing domain with a known TLD pointing to your Appwrite instance.
Your _APP_ENV environment variable should be set for production mode. The default Appwrite setup comes with this predefined setting, so you should be OK unless you change it.
You need to ensure you have a valid email address set on _APP_SYSTEM_SECURITY_EMAIL_ADDRESS. The default setup comes with certs@appwrite.io as the default value. While this address will work, it's recommended to change it to your own email.
Currently, Appwrite is using the ACME HTTP challenge to issue an TLS certificate. This forces us to generate certificates for port 443 when the challenge itself is performed on port 80. At this point, other ports will not work. To overcome this limit, you can set Appwrite on a separate sub-domain or use your own certificate or proxy server in front of Appwrite.
Debugging
If you're still struggling with your certificates, check the Appwrite certificates worker log. You can do that with the following command:

docker compose logs appwrite-worker-certificates
Click Here to Copy
Generation Cycle
Appwrite auto-generates a certificate for your main domain when you first visit it. If your browser shows an insecure connection warning, you must proceed to trigger certificate generation. The domain in environment variable _APP_DOMAIN is considered your main domain. If you didn't set this variable, the first domain you visit would be marked as the main domain for your Appwrite instance. Appwrite follows this concept of the main domain to prevent generating certificates for domains you don't own. Keep in mind that you can always add additional domains as Custom Domains in your project settings to enable certificate generation for any domain.

Certificate renewal is done as a part of the Appwrite maintenance task. Unless modified with environment variable _APP_MAINTENANCE_INTERVAL, this task runs every 24 hours. During this task, Appwrite looks for certificates due for renewal and renews them. One maintenance cycle only attempts to renew up to 200 certificates to respect the Let's Encrypt API limit. Every Let's Encrypt certificate is valid for 90 days, but Appwrite starts to renew them 30 days before the expiration.

There are many reasons why certificate generation could fail, such as incorrect DNS settings, hitting Let's Encrypt API limit, or a failed HTTP ACME challenge. Every certificate generation failure is attempted again in the next renewal cycle, but only up to 5 attempts. If you need to run certificate generation for a domain beyond the attempts limit, you can use the manual generation method.

Manual Generation
Since Appwrite generates and renews certificates automatically, a manual generation is seldom required. A manual generation can be useful when you hit the API limit and don't want to wait for the next maintenance cycle to renew the certificate. Use the following command to generate a certificate for your main domain:

docker compose exec appwrite ssl
Click Here to Copy
If you want to generate a certificate for a specific domain, pass it as a parameter into the command:

docker compose exec appwrite ssl domain="api.myapp.com"
Click Here to Copy
Dev Environment and Localhosts
You can't issue a signed certificate for localhost. This is because nobody uniquely owns that hostname and not an Appwrite specific limitation, just the way the internet works. By default, Appwrite will issue a self-signed certificate that is good enough for development.

When using a self-signed certificate, you should enable `client.setSelfSigned()` method in your SDK of choice. This will allow your application to trust and connect with your local Appwrite server.

Debugging
Appwrite comes with a few built-in tools and methods that easily debug and investigate issues on your Appwrite stack environment.

Doctor CLI  available from >= v0.7
The doctor CLI helps you validate your server health and best practices. Using the Doctor CLI, you can verify your server configuration for best practices, validate your Appwrite stack connectivity and storage read and write access, and available storage space.

To run the Doctor check, simply run the following command from your terminal. You might need to replace 'appwrite' with your Appwrite Docker container ID. To find out what's your container ID, you can run `docker ps` command (more on that, in the next section).

docker exec appwrite doctor
Click Here to Copy
Logs
Checking your Appwrite containers can be a great way to pinpoint where and what exactly happens inside your Appwrite services. You can list your Appwrite containers using the following command in your terminal:

docker ps
Click Here to Copy
The output of this command will show you a list of all your running Docker containers, their ID's, uptime, and open ports. You can use each container ID to get a list of all the container `stdout` and `stderr` logs by using the following command:

docker logs [CONTAINER-ID]
Click Here to Copy
Status Codes
Appwrite uses conventional HTTP response codes to indicate the success or failure of an API request. In general: Codes in the 2xx range indicate success. Codes in the 4xx range indicate an error that failed given the information provided (e.g., a required parameter was omitted, invalid input, etc.). Codes in the 5xx range indicate an error with the Appwrite server, but these are rare.

Learn more about Appwrite status codes

Dev Mode
When moving to dev mode, your server will produce much more verbose error messages. Instead of getting a general 500 error, you'll be able to view the exact error that happened on the server, debug the issue further or report it to the Appwrite team.

To change your dev environment, edit your server _APP_ENV environment variable from 'production' to 'development' in your Appwrite docker-compose.yml file located in the `appwrite` directory in the location where you first installed Appwrite.

...
    - influxdb
    - telegraf
environment:
    - _APP_ENV=development
    - _APP_OPENSSL_KEY_V1=your-secret-key
    - _APP_DOMAIN=localhost
...
Click Here to Copy
After you completed the change in the docker-compose.yml file, save it and run the following command to restart Appwrite with your new settings:

docker compose up -d

Upgrade
To upgrade your Appwrite server from an older version, you should use the Appwrite migration tool after you have installed the new version. The migration tool will adjust your Appwrite data to the new version's structure to make sure your Appwrite data is compatible with any internal changes.

As of version 0.14, Appwrite requires Docker Compose Version 2. To upgrade Appwrite, make sure your Docker installation is updated to support Composer V2.

A Note About Migration
At present, we support migrations only to the immediately higher versions, i.e from 0.6 to 0.7 and 0.7 to 0.8 and so on. So if you're trying to migrate from 0.6 to 0.8, you will first need to migrate to 0.7 and then to 0.8

It is highly recommended to backup your server data before running the migration. It is recommended to run the migration process on a dev instance and make sure your application is working well and that you have checked for any breaking changes in the new version changelog.

The first step is to install the latest version of Appwrite. Head to the directory where you ran your previous Appwrite install command.

parent_directory <= you run the command in this directory
    └── appwrite
        └── docker-compose.yml
Click Here to Copy
This is the parent directory where you will find the appwrite directory, inside which there are docker-compose.yml and .env files.

Installing the Next Version
docker run -it --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume "$(pwd)"/appwrite:/usr/src/code/appwrite:rw \
    --entrypoint="install" \
    appwrite/appwrite:1.2.1
Click Here to Copy
This will pull the docker-compose.yml file for the new version and perform the installation. Once the setup completes, verify that you have the latest version of Appwrite.

docker ps | grep appwrite/appwrite
Click Here to Copy
Verify that the STATUS doesn't have any errors and all the appwrite/appwrite containers have version : 1.2.1

Running the Migration
Upgrading to a minor version
You do not need to run migration when upgrading to a minor version. For example, going from 0.13.0 to 0.13.2 would not require running migration.

We can now start the migration. Navigate to the appwrite directory where your docker-compose.yml is present and run the following command

cd appwrite/
docker compose exec appwrite migrate
Click Here to Copy
The data migration can take longer depending on the amount of data your Appwrite instance contains. The Appwrite migration command uses multi-threading to speed up the process, meaning that adding more CPU cores can help speed up the process.

Once the migration process has been completed successfully, you're all set to use the latest version of Appwrite!

Certificates for localhost
Last updated: Dec 21, 2017 | See all Documentation

Sometimes people want to get a certificate for the hostname “localhost”, either for use in local development, or for distribution with a native application that needs to communicate with a web application. Let’s Encrypt can’t provide certificates for “localhost” because nobody uniquely owns it, and it’s not rooted in a top level domain like “.com” or “.net”. It’s possible to set up your own domain name that happens to resolve to 127.0.0.1, and get a certificate for it using the DNS challenge. However, this is generally a bad idea and there are better options.

For local development
If you’re developing a web app, it’s useful to run a local web server like Apache or Nginx, and access it via http://localhost:8000/ in your web browser. However, web browsers behave in subtly different ways on HTTP vs HTTPS pages. The main difference: On an HTTPS page, any requests to load JavaScript from an HTTP URL will be blocked. So if you’re developing locally using HTTP, you might add a script tag that works fine on your development machine, but breaks when you deploy to your HTTPS production site. To catch this kind of problem, it’s useful to set up HTTPS on your local web server. However, you don’t want to see certificate warnings all the time. How do you get the green lock locally?

The best option: Generate your own certificate, either self-signed or signed by a local root, and trust it in your operating system’s trust store. Then use that certificate in your local web server. See below for details.

For native apps talking to web apps
Sometimes developers want to offer a downloadable native app that can be used alongside a web site to offer extra features. For instance, the Dropbox and Spotify desktop apps scan for files from across your machine, which a web app would not be allowed to do. One common approach is for these native apps to offer a web service on localhost, and have the web app make requests to it via XMLHTTPRequest (XHR) or WebSockets. The web app almost always uses HTTPS, which means that browsers will forbid it from making XHR or WebSockets requests to non-secure URLs. This is called Mixed Content Blocking. To communicate with the web app, the native app needs to provide a secure web service.

Fortunately, modern browsers consider http://127.0.0.1:8000/ to be a “potentially trustworthy” URL because it refers to a loopback address. Traffic sent to 127.0.0.1 is guaranteed not to leave your machine, and so is considered automatically secure against network interception. That means if your web app is HTTPS, and you offer a native app web service on 127.0.0.1, the two can happily communicate via XHR. Unfortunately, localhost doesn’t yet get the same treatment. Also, WebSockets don’t get this treatment for either name.

You might be tempted to work around these limitations by setting up a domain name in the global DNS that happens to resolve to 127.0.0.1 (for instance, localhost.example.com), getting a certificate for that domain name, shipping that certificate and corresponding private key with your native app, and telling your web app to communicate with https://localhost.example.com:8000/ instead of http://127.0.0.1:8000/. Don’t do this. It will put your users at risk, and your certificate may get revoked.

By introducing a domain name instead of an IP address, you make it possible for an attacker to Man in the Middle (MitM) the DNS lookup and inject a response that points to a different IP address. The attacker can then pretend to be the local app and send fake responses back to the web app, which may compromise your account on the web app side, depending on how it is designed.

The successful MitM in this situation is possible because in order to make it work, you had to ship the private key to your certificate with your native app. That means that anybody who downloads your native app gets a copy of the private key, including the attacker. This is considered a compromise of your private key, and your Certificate Authority (CA) is required to revoke your certificate if they become aware of it. Many native apps have had their certificates revoked for shipping their private key.

Unfortunately, this leaves native apps without a lot of good, secure options to communicate with their corresponding web site. And the situation may get trickier in the future if browsers further tighten access to localhost from the web.

Also note that exporting a web service that offers privileged native APIs is inherently risky, because web sites that you didn’t intend to authorize may access them. If you go down this route, make sure to read up on Cross-Origin Resource Sharing, use Access-Control-Allow-Origin, and make sure to use a memory-safe HTTP parser, because even origins you don’t allow access to can send preflight requests, which may be able to exploit bugs in your parser.

Making and trusting your own certificates
Anyone can make their own certificates without help from a CA. The only difference is that certificates you make yourself won’t be trusted by anyone else. For local development, that’s fine.

The simplest way to generate a private key and self-signed certificate for localhost is with this openssl command:

openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
You can then configure your local web server with localhost.crt and localhost.key, and install localhost.crt in your list of locally trusted roots.

If you want a little more realism in your development certificates, you can use minica to generate your own local root certificate, and issue end-entity (aka leaf) certificates signed by it. You would then import the root certificate rather than a self-signed end-entity certificate.

You can also choose to use a domain with dots in it, like www.localhost, by adding it to /etc/hosts as an alias to 127.0.0.1. This subtly changes how browsers handle cookie storage.