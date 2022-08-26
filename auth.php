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
      	
        $sql = "select *from Login where UserId = '$username' and Password = '$password'";  
        $result = mysqli_query($con, $sql);  
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);  
        $count = mysqli_num_rows($result);  
        
        
        
        if($count == 1){  
            
        $sql = "select *from Student where snum = '$id' ";  
        $result = mysqli_query($con, $sql);  
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);
        $name=$row['sname'];
        echo "<h1><center> Welcome '$name' </center></h1>"; 
        echo "<h2>'$name' Profile: </h2>";
        $snum=$row['snum'];
	$major=$row['major'];
	$level=$row['level'];
	$age=$row['age'];
	echo "<b>Roll No: '$snum'  </b>";
	echo "<b><br>Name   :'$name' </b>";	 		
        echo "<b><br>Major  : '$major'</b>";
        echo "<b><br>Level  : '$level'</b>";
        echo "<b><br>Age    : '$age'</b>";
        echo "<h2>'$name' Courses Enrolled: </h2>";
        $sql = "select cname from Enrolled where snum = $id ";  
        $result = mysqli_query($con, $sql);  
        

	while ($row = mysqli_fetch_assoc($result)) 
	{
		echo "<b>";
		echo $row['cname'];
		echo "<br> </br>";
		
		  
	}
	
        }  
        else{  
            echo "<h1> Login failed. Invalid username or password.</h1>";  
        }   
        
       mysqli_close($con);  
?>  
