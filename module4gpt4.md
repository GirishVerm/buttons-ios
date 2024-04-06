# Module 4: Automation and Scripting

## Subtopic: Bash Scripting

Scripting offers powerful programming capabilities to tinker around Linux operating system's functionality, automate routine processes, and make life much easier. Bash stands for "Bourne Again SHell" is the most commonly used shell in Linux systems. It is an open-source GNU project that was intended to replace the original Bourne Shell (sh). In this module, we will learn the basics of Bash scripting, including the structure of a shell script, variables, control flow, user dialogue, and more.

### Introduction to Bash Scripting

Before we dive into Bash scripting, it's important to emphasize that Bash is not only a shell, it’s also a scripting language. It is an interpreter that allows for command line scripting and process management. This powerful tool can combine simple commands into scripts to automate routine tasks.

```bash
#!/bin/bash
echo "Hello, World!"
```
The above code is a simple Bash script that prints "Hello, World!" to the console. The first line of the script begins with " `#!/bin/bash`". This line tells the system that this script needs to be run by Bash shell.

### Basic Components of a Bash Script

Every Bash script mainly consists of the following essential components:

1. Shebang (`#!/bin/bash`) : It is placed on the first line of your script to tell your system to interpret the script commands through the Bash shell.

2. Comments : Anything after a `#` is a comment, apart from the Shebang which is a special type of comment.

3. Commands : Any command that you can run in the terminal can be used in a script.

4. Variables : Variables are containers for temporary storage. To assign a value to a variable, you must omit the $ (dollar sign) and to reference/access the value, you will include the $.

5. Control structures : Bash scripts also have control structures like if-else, while, for, switch-case etc.

6. Functions : Bash scripting support the concept of functions that can be reused any number of times.

### Variables and Parameters

Variables are a central feature that allow to store and manipulate information in Bash scripts.

```bash
#!/bin/bash

hello="Hello, World!"

echo $hello
```
In this script, we first assign a string "Hello, World!" to a variable hello and then print the value of hello using echo command. 

### Conditional Statements

Just like any other programming language, Bash scripts support conditional statements - if, if-else, and else-if. These conditional statements help us make decisions, whether we need to run a block of code or not.

```bash
#!/bin/bash
count=10 if [ ${count} -eq 10 ] 
then
    echo "the count is 10" 
fi
```
In the script above, we are comparing the variable 'count' with the value 10. If the comparison is true, then the script will echo "the count is 10".

### Loops

Loops are used to perform repetitive tasks. In bash, we have the following loop constructs: `for`, `while`, and `until`.

```bash
#!/bin/bash
for i in {1..5}
do
    echo "Welcome $i times"
done
```
The script above will print "Welcome $i times" 5 times. It uses a range in braces ({1..5}), which means it runs from 1 to 5.

### Functions 

Functions in Bash Scripting are a great way to reuse code. They are blocks of code that you can name and execute any number of times.

```bash
#!/bin/bash 
welcome_user() {
    echo "Welcome ${1}"
}

welcome_user "John Doe"
```
In this script, we have defined a function named 'welcome_user'. The function takes an argument and prints "Welcome" followed by the argument value.

### Conclusion

This is a beginner's guide to Bash scripting. Bash scripting is a vast topic with a lot of aspects. The skills you have gained here will help you write scripts to automate tedious tasks and more effectively manage your Linux system. Scripting is extremely powerful and makes for an essential tool in your box as a system administrator.

Remember, "practice makes perfect". The more scripts you write, the more fluent and comfortable you will be in writing bash scripts. Don't hesitate to explore and utilize the extensive feature set that bash scripting provides. Finally, remember to comment on your scripts. This will not only help others who might be reading your scripts, but also you, when you come back to a script you wrote months or years ago. # Automation with Ansible

Ansible is a powerful tool that is primarily used for software provisioning, configuration management, and application deployment. It helps in glueing together the entire IT infrastructure and makes intercommunication among various teams like developers, systems engineers, and IT operations easy. Ansible's main strength is its simplicity, and it does not require any daemons and servers (therefore, no extra software or firewall ports).

This section will provide a thorough understanding of Automation with Ansible outlining its importance, how it works, installation, playbook overview, and how to create and run Ansible playbooks.

## 1. Understanding Ansible

Ansible is an automation tool, similar to Puppet and Chef but far less complex to use. It is fully open source and built with Python. With Ansible, you can automate three types of tasks:

- Provisioning: Setting up the various servers you need in your infrastructure.
- Configuration management: Changing the settings on an operating system, on a application, installing a service, or starting a service.
- Application deployment: Deploy your applications on your infrastructure.

Ansible uses a simple syntax written in YAML (Yet Another Markup Language), which is easy to read and write. The code written in YAML is referred to as a "playbook". A playbook can include one or more plays, where each play defines the work for a configuration management server.

## 2. How Ansible Works

Ansible operates by connecting your nodes and pushing out small programs, called "Ansible modules" to them. Then it executes these modules over SSH and removes them when finished.

![How Ansible Works](https://www.ansible.com/hubfs/images/Diagrams/ansible_architecture_diagram.png)

The controlling machine, where Ansible is installed is where orchestration begins. The locations where the modules are installed, and task executions happen is called 'nodes'. Nodes are managed by the controlling machine over SSH, which is installed by default, and Ansible ensures that they are in a desired state.

## 3. Installing Ansible

Installation of Ansible is a simple process, and it does not require any special requirements to get started. Here are the steps involved in installing Ansible:

```python
# Update system
sudo apt-get update

# Install software-properties-common package
sudo apt-get install software-properties-common

# Add Ansible's official ppa (personal package archive)
sudo apt-add-repository ppa:ansible/ansible

# Update your system with the new ppa
sudo apt-get update

# Install Ansible
sudo apt-get install ansible
```

After running these commands, you can check if Ansible is installed by:
```python
# Checking Ansible version
ansible --version
```

## 4. Playbook Overview

In Ansible, the playbook is the primary basis for sending commands to remote machines to automate everything. They are written in YAML and are human-readable. A playbook contains plays, and a play consists of tasks.

Playbooks are designed to be human-readable and develop in a basic text language. Each playbook is composed of one or more 'plays' in a list. The goal of a play is to map a group of hosts to some well-defined roles, represented by things Ansible calls tasks.

At a basic level, you can write a playbook as below:

```python
---
- hosts: webservers
  tasks:
    - name: ensure apache is at the latest version
      apt: name=apache2 state=latest
    - name: write the apache config file
      template: src=/srv/httpd.j2 dest=/etc/httpd.conf
      notify:
      - restart apache
  handlers:
    - name: restart apache
      service: name=httpd state=restarted
```

This playbook will target hosts in the 'webservers' group and apply two tasks: 1) Install/update Apache 2) If the Apache configuration file changes, Ansible will restart Apache.

## 5. Creating and Running an Ansible Playbook

To create an Ansible playbook, you follow these steps:

```python
# Create a YAML playbook file
touch myplaybook.yml
# Edit the playbook file
nano myplaybook.yml
# Write the necessary plays and tasks
# Save and exit
```

To run an Ansible playbook, you execute:

```python
ansible-playbook myplaybook.yml
```

This command will execute all the tasks defined in your playbook on all the hosts that your playbook is targeted at.

Automation with Ansible is a vast topic that includes inventory files, different modules, playbooks and plays, ad hoc commands, and much more. This document is basic guidance for a beginner to start with Ansible's automation. To excel in automating the tasks with Ansible, learn the modules, playbooks, and inventory files more in-depth. Also, knowing the use cases where Ansible fits perfectly will help in utilizing it more effectively. # Module 4: Automation and Scripting

## Subtopic: Managing Cron Jobs

A Cron job is a Unix/Linux utility which allows tasks to be automatically run in the background at regular intervals by the cron daemon. These tasks are often termed as "Cron Jobs". A cron job is the scheduled task itself, allowing server administrators to schedule jobs (scripts to be executed) at periodic schedules. 

A crontab file is a simple text file containing a list of commands meant to be run at specified times. It is edited using the `crontab` command. The commands in the crontab file (and their run times) are checked by the cron daemon, which executes them in the system background.

### 1. Understanding Cron Syntax:

Each line of a crontab file follows a particular syntax. It represents a single cron job and follows this syntax in order to configure the cron job.

```
*     *     *   *    *        command to be executed
-     -     -   -    -
|     |     |   |    |
|     |     |   |    ----- Day of week (0 - 6) (Sunday=0)
|     |     |   ------- Month (1 - 12)
|     |     --------- Day of month (1 - 31)
|     ----------- Hour (0 - 23)
--------- Minute (0 - 59)

```
Each of the sections is separated by a space, with the final section (the command to be executed) having one or more spaces in it.

### 2. Scheduling a Cron Job:

To create a new cron job, you can use the command `crontab -e`. This command opens the crontab file for the current user. Here's an example of how you might schedule a simple cron job:

1. Start by opening your terminal.
2. Type `crontab -e`.
3. Choose the editor you want to use. Note: This is only necessary the first time you use `crontab -e`.
4. Now, add a line for your cron job. For example, to schedule a job that runs at 2 am every day, you would add the line: `0 2 * * * command_to_be_executed`.

This command will open a crontab file with the chosen editor (if it's been chosen for the first time). We can add an entry to this file to schedule a cron job.

### 3. Common Crontab Commands:

* `crontab -e`: Edit crontab file, or create one if it doesn’t exist.
* `crontab -l`: Crontab list of cronjobs , display crontab file contents.
* `crontab -r`: Remove your current crontab file.
* `crontab -v`: Display the last time you edited your crontab file. (This option is only available on a few systems)

### 4. Cron Job Examples:

Here are a few examples of cron job schedules:

1. To schedule a cron job that runs every minute: `* * * * * command_to_be_executed`
2. To schedule a cron job that runs every Sunday at 5 PM: `0 17 * * SUN command_to_be_executed`
3. To schedule a cron job that runs on the first day of every month: `0 0 1 * * command_to_be_executed`

### 5. Managing Output

It's crucial to make sure that the output from your cron jobs is managed appropriately. If the output is not managed, it will be emailed to the user account attached to the cron job. To avoid filling up your inbox, it's good practice to direct your cron job's output to a log file:

`* * * * * myscript.sh >> /var/log/myscript.log 2>&1`

This command will log all output (including errors) to `/var/log/myscript.log`.

By managing cron jobs efficiently, sysadmins can automate the process of maintaining a Linux system. Most of the system's routine tasks can be automated with the help of cron jobs. However, sysadmins must always stay aware of the system's processing power and memory capacity to ensure that running cron jobs do not unnecessarily consume these resources.

Remember, use system automation responsibly. # Module 4: Automation and Scripting
## Subtopic: System Logging

Logging is an essential aspect of system administration and troubleshooting. When things go wrong, logs provide detailed context that can help determine what happened and why. In this section, we will explore how to manage and manipulate system logs, understand their importance, and learn where to find them.

In Linux systems, logs are generally kept in the /var/log directory. Numerous files and subdirectories are located in this directory, each serving a different purpose or recording a specific type of event.

### What is System Logging?

System Logging refers to the process of storing event logs generated by system activities. The system generates a log message that indicates the event type, occurrence time, event source, and specific details provided by the event source. These logs contain information about hardware changes, software crashes, system errors, or various process statuses. 

### Types of System Logs

- **System Logs**: - Records the system's activity and provides a broad view of what's happening on the system.
- **Application Logs**: - Record events related to various applications running on the system.
- **Security Logs**: - Monitor and record security-related events for auditing and tracking potential threats.
- **Event Logs**: - Provide a historical record of all notifications and alerts that have occurred.

### Understanding Basic Linux Logs

Linux has various logs that are used to record different aspects of system activity. Here are just a few:

1. **syslog (/var/log/syslog or /var/log/messages)**: The main system log file, which contains most system activity reports.
2. **kern.log (/var/log/kern.log)**: This is where kernel boot and runtime messages are logged.
3. **auth.log (/var/log/auth.log)**: Logs all authentication related events, including successful and failed logins.
4. **boot.log (/var/log/boot.log)**: Logs all messages generated during system startup.

### Understanding Logging Priorities

Each log message is assigned with a priority, a tag that describes its importance. The priorities are as follows:

1. **Debug**: Detailed debug information.
2. **Info**: Informational messages.
3. **Notice**: Normal but significant conditions.
4. **Warning**: Warning conditions.
5. **Error**: Error conditions.
6. **Crit**: Critical conditions.
7. **Alert**: Immediate action required.
8. **Emerg**: System is unusable.

### Exploring logs: Using the `cat`, `more` and `less` commands

The simplest way to inspect a log is to print it directly to the console. You can accomplish this by using the `cat` command. However, most log files can be extensive and difficult to read in one setting. The `more` and `less` commands allow you to step through the file one screen or one line at a time, respectively.

```Bash
cat /var/log/syslog
more /var/log/syslog
less /var/log/syslog
```

### Filtering logs: Using `grep`

When dealing with large log files, it’s beneficial to filter them for the specific information you need. The `grep` command is used to search for a specific string in a file. 

```Bash
grep 'error' /var/log/syslog
```
This command will return all lines that contain the word "error".

### Log Rotation

Log files can grow enormous, so it's a common practice to use log rotation to manage their size. Log rotation is a process that periodically archives current logs and creates new ones. The `logrotate` utility in Linux handles this process. 

Linux systems usually rotate logs regularly using a cron job, an automatic task set to run at specific times. By default, log files are rotated weekly, and four weeks' worth of logs are kept. However, this can be customized to suit your needs.

### Monitoring logs in real time: `tail -f`

To monitor logs in real-time, the `tail -f` command is used. It prints the last ten lines of a file and then outputs appended lines as they come. This command is useful for following logs in real time.

```Bash
tail -f /var/log/syslog
```

Understanding and utilizing system logs is an essential skill for any System Administrator. Always remember, when things go wrong, logs are there to provide you invaluable insight into your system's operations. # Monitoring and Performance Tuning in Linux

Performance tuning and monitoring are essential for managing and maintaining your Linux systems. Performance issues can lead to diminished productivity and can negatively affect the user experience. Effective monitoring can help you identify potential issues before they become serious problems, while tuning can help you optimize your system for peak performance. In this module, you'll learn the concepts and techniques for monitoring and performance tuning in Linux.

## Understanding Linux Monitoring 

Linux monitoring involves keeping track of various metrics that can provide insights into the system's performance. These metrics include the CPU usage, memory usage, disk I/O, network I/O, and system load, among others. Monitoring these metrics can give you an idea of how your system is performing and if there are any potential bottlenecks or issues that need to be addressed.

### Monitoring Tools

There are several tools that you can use to monitor your Linux systems. These tools provide a graphical or command-line interface that you can use to view real-time or historical data about your system's performance. Some common Linux monitoring tools include:

- **top**: This is a real-time command-line tool that provides a dynamic view of the processes running on your system. It can display information about the CPU usage, memory usage, and system load.
- **vmstat**: This tool provides information about your system's memory, processes, interrupts, and CPU activity.
- **iostat**: This tool is used to monitor your system's disk I/O.
- **netstat**: This tool provides information about your system's network connections, routing tables, and interface statistics.
- **sar**: This is a command-line tool that can collect and report system activity information.

## Understanding Linux Performance Tuning

Performance tuning in Linux involves optimizing your system's performance by adjusting various system parameters and settings. Tuning can help you maximize your system's throughput, reduce latencies, and improve its overall performance. Effective tuning requires a good understanding of the Linux kernel and how your system interacts with the hardware.

### Tuning Tools

There are several tools that you can use to tune your Linux systems. These tools provide a command-line interface that you can use to adjust various system parameters and settings. Some common Linux tuning tools include:

- **sysctl**: This tool allows you to read and modify kernel parameters at runtime.
- **nice and renice**: These tools can be used to control the CPU scheduling priority of your processes.
- **ionice**: This tool allows you to control the I/O scheduling class and priority of your processes.
- **ulimit**: This tool can limit the resources that are available to your shell and its descendant processes.

## Monitoring and Tuning Best Practices

When it comes to monitoring and performance tuning in Linux, there are a few best practices that you should follow:

1. **Identify the bottlenecks**: Before you start tuning your system, it's important to identify the potential bottlenecks. This will allow you to focus on the areas that can have the most impact on your system's performance.
2. **Use the right tools**: Make sure to use the right tools for the job. Each monitoring and tuning tool has its strengths and weaknesses, so it's important to choose the tools that best suit your needs.
3. **Understand the trade-offs**: Tuning often involves making trade-offs. For example, optimizing your system for high throughput might lead to increased latencies. So, it's important to understand these trade-offs before making any changes to your system.
4. **Keep an eye on key metrics**: Make sure to keep an eye on key metrics like CPU usage, memory usage, and disk I/O. If these metrics are consistently high, it could indicate a performance issue that needs to be addressed.
5. **Regularly check your system's performance**: Regularly check your system's performance to ensure that it's running optimally. Any changes in your system's performance could indicate a potential issue that needs to be addressed.

## Summary

Monitoring and performance tuning are crucial for managing and maintaining your Linux systems. By understanding the concepts and techniques of monitoring and tuning, and by using the right tools, you can effectively manage your system's performance and potentially prevent serious performance issues. Remember that always it's much better to proactively monitor and tune your system than reactively fixing performance issues after they've occurred.

=== Code Execution Successful ===
