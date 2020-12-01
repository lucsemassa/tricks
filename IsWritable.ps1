 function IsWritable($path_to_check){ 
 
	if( -not (Test-Path $path_to_check)){
	Write-Output("The path provided doesn't exist");
	return false;
	}
	
    $myuser = $env:UserName;
    $value_to_return = $false;

    if ((Get-Acl $path_to_check).access | ft | Out-String | findStr $myuser | Select-String -Pattern "Allow" |Select-String "(FullControl)|(Modify)|(Write)") {return $true;}

    $groups = ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups).Value | foreach-Object{
      $objSID = New-Object System.Security.Principal.SecurityIdentifier ($_); 
      try {
        Write-Output ($objSID.Translate( [System.Security.Principal.NTAccount])).Value  
    }
    catch {

    }
}  

$groups | ForEach-Object {
  $groupeName=$_;
  
  (Get-Acl $path_to_check).access | ForEach-Object{

    if ( $_ | ft | Out-String | Select-String -Pattern "Allow" | Select-String -Pattern $groupeName.replace("\","\\") | Select-String "(FullControl)|(Modify)|(Write)") {$value_to_return=$true; } 
}
}
return $value_to_return;
}
