# Powershell Test Data Exfiltration
### Powershell Script to Test Data Exfiltration using TOR exit nodes
  
 
This script was created for a classroom in firewall learning to test if the basic firewall rules configured are enough to pass this data exfiltration test.

🛠 Motivation  
Get our students hands-on on basic data exfiltration techniques. This script for now only test connections with tor exit nodes, with both http(s) ports and other not well common service ports.

✨ How It Works  
In the file data.dat you will find the list of ip's and ports that i've got when scanning a list of tor exit nodes.  
You can grab tor node exit ip's on: https://check.torproject.org/torbulkexitlist

💈 How to Use It  
Clone this reporitory or download it as a zip.  
Execute the script Test_Data_Exfiltration.ps1.  
```Powershell -EP ByPass -File Test_Data_Exfiltration.ps1```  
Wait for results.
