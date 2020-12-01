#Tricks 

## Windows 

### Find Writable directory
In Linux you have probably heard about find command with -writable option which can help you to know which files or directories you can edit as the user you logged in.
Unfortunately, windows does not have a such built in command which can show those details in one command.

The purpose of this powershell script is to check if any folder or file can be edited as the user your are logged in. It takes the file/directory ACL and check the permissions against the user and belonging **group**

How to use
```
#if Powershell Execution policy is restricted, run the following as Administrator
Set-ExecutionPolicy Bypass

#Import the IsWritable defined inside the script 
. .\IsWritable.ps1

#Check if directory or file is writable
IsWritable("C:\Users\Administrator")

IsWritable("full_path_to_my_file")
```
