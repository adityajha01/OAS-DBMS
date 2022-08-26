<?php      
    $host = "localhost";  
    $usr = "root";  
    $pwd = '';  
    $db_name = "College_db";  
      
    $con = mysqli_connect($host, $usr, $pwd, $db_name);  
    
    if(mysqli_connect_errno()) {  
        die("Failed to connect with MySQL: ". mysqli_connect_error());  
    }   
    $username = $_POST['user'];  
    $password = $_POST['pass'];  
      
        //to prevent from mysqli injection  
        $username = stripcslashes($username);  
        $password = stripcslashes($password);
        
        $username = mysqli_real_escape_string($con, $username);  
        $password = mysqli_real_escape_string($con, $password);  
      	$id=$username;
      	
        $sql = "select *from Flogin where UserId = '$username' and Password = '$password'";  
        $result = mysqli_query($con, $sql);  
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);  
        $count = mysqli_num_rows($result);  
        
        
        
        if($count == 1){  
            
        $sql = "select *from Faculty where fid = '$id' ";  
        $result = mysqli_query($con, $sql);  
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
        $name=$row['fname'];
        echo "<h1><center> Welcome '$name' </center></h1>"; 
        echo "<h2>'$name' Profile: </h2>";
        $fnum=$row['fid'];
	$dept=$row['deptid'];
	
	echo "<b>Faculty ID       : '$fnum'  </b>";
	echo "<b><br>Faculty Name :'$name' </b>";	 		
        echo "<b><br>Department No: '$dept'</b>";
       
        echo "<h2>'$name' Course Details : </h2>";
        $sql = "select name from Class where fid = $id ";  
        $result = mysqli_query($con, $sql);  
        

	while ($row = mysqli_fetch_assoc($result)) 
	{
		echo "<b>";
		echo $row['name'];
		echo "<br> </br>";
		
		  
	}
	
        }  
        else{  
            echo "<h1> Login failed. Invalid username or password.</h1>";  
        }   
        
       mysqli_close($con);  
?>  
