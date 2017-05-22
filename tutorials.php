<html><body>
<h1><u> Tutorial Booking System </u></h1>
<?php
$db_hostname = "mysql";
$db_database = "u3mk";
$db_username = "u3mk";
$db_password = "bonjourmysql";

$failed = false;

//start session 
session_start();
//connect to database
$con = mysqli_connect($db_hostname,$db_username,$db_password,$db_database);
if (!$con) die("Unable to connect to MySQL: ".mysqli_connect_error());
//turn off auto commit 
mysqli_autocommit($con, FALSE);

//Check if user attempts to book a slot 
if(isset($_POST["book"])){
	//Check if name email or question is left empty
	if(trim($_POST["name"])==false || trim($_POST["email"])==false || trim($_POST["questions"])==false){
		echo "<font color=\"red\"><b>Please fill in all of the fields before submitting </b></font></br>";
        
	} else {
		//Check if a time or day has been selected
		if(!isset($_SESSION["time"]) || $_SESSION["time"] == 0){
			echo "<font color=\"red\"><b>Select a day and time before booking </b></font></br>";
            
		}else {
			/*copy values from form to session variables
            trim = get rid of spaces at front and back of string
            preg_replace = remove characters that don't appear in names
                            such as ' @ / etc            
            */
			$_SESSION["getName"] = trim($_POST["name"]);
            $_SESSION["getName"] = preg_replace("/[\/\\\.\"']/","",$_SESSION["getName"]);
			$_SESSION["getEmail"] = trim($_POST["email"]);
            $_SESSION["getEmail"] = preg_replace("/[\/\\\"']/","",$_SESSION["getEmail"]);
			$_SESSION["getQuestions"] = trim($_POST["questions"]);
			
			//Query to check if there is space for selected tutorial
			$checkQuery = "select capacity from tutorial where id = ".$_SESSION["time"];
			$checkResult = mysqli_query($con,$checkQuery);
			$checkResult || die("Database access failed: ".mysqli_error($con));
			$capArr = mysqli_fetch_array($checkResult, MYSQLI_BOTH);
			$cap = $capArr[0];
			//There is room in selected tutorial
			if($cap > 0){
				//prepare statement for insert new booking
				//prevent code injection
				$stmt = mysqli_stmt_init($con);
				$stmt = mysqli_prepare($con, "insert into booking (TutorialID,Name,Email,Questions) values(".$_SESSION["time"] .",?,?,?)");
					mysqli_stmt_bind_param($stmt, "sss", $_SESSION["getName"], $_SESSION["getEmail"], $_SESSION["getQuestions"]);
					$success = mysqli_stmt_execute($stmt);
					mysqli_stmt_close($stmt);
			
				//reduce capacity by 1 for selected tutorial 
				$capReduceQuery = "update tutorial set capacity = capacity-1 where id = ".$_SESSION["time"];
				$capReduceResult = mysqli_query($con, $capReduceQuery);
				
					
					
					
				if($success && $capReduceResult){
					//if both queries were successful, commit transaction
					mysqli_commit($con);
					echo "<font color=\"green\"><b>Successfully booked tutorial session!<b></font>";
                    //reset session variables
				    session_unset();
				} else {
					//else roll back (don't decrease capacity by 1)
					mysqli_rollback($con);
					echo "<font color=\"red\"><b>Booking error. Please try again. </b></font></br>";
                    $failed = true;

				}
				
			} else {
				//no room in selected tutorial : display error msg
				echo "<font color=\"red\"><b>Someone already booked this slot!</b></font></br>";
                $failed = true;
			}
		}
	}
}

//Check to see if there are any more tutorial slots left
$sumCapQuery = "select sum(capacity) from tutorial";
$sumCapResult = mysqli_query($con,$sumCapQuery);
$sumCapResult || die("Database access failed: ".mysqli_error($con));
$sumCapArr = mysqli_fetch_array($sumCapResult, MYSQLI_BOTH);
$sumCap = $sumCapArr[0];
if($sumCap<=0){
	die("</br> <b>No tutorial slots remaining</b>");
}


//Initialize session variables to 0 if not set.
//(on first load of web page, dropdown menus are on default options)
if(!isset($_SESSION["day"])){
	$_SESSION["day"] = 0;
}
if(!isset($_SESSION["time"])){
	$_SESSION["time"] = 0;
}

//store value of selected dropdown in session variables
if(isset($_POST["dropdown1"])){
	$_SESSION["day"] = $_POST["dropdown1"];
}
if(isset($_POST["dropdown2"])){
	$_SESSION["time"] = $_POST["dropdown2"];
}


/*
$query = "select * from tutorial";
$result = mysqli_query($con,$query);
$result || die("Database access failed: ".mysqli_error($con));
$finfo = mysqli_fetch_fields($result);
echo "<table border=¡¯1¡¯ cellpadding=¡¯5¡¯>\n";
echo "<tr>";
foreach($finfo as $val){
		echo "<td>", $val->name, "</td>";
}

	while($row = mysqli_fetch_array($result, MYSQLI_BOTH)){
		echo "<tr>";
		echo "<td>", $row[0], "</td>";
		echo  "<td>",$row[1], "</td>";
		echo  "<td>",$row[2],"</td>";
		echo  "<td>",$row[3],"</td>";
		echo "<tr>";
	}
echo "</tr>";
echo "</br>";
mysqli_free_result($result); // free memory

$query = "select * from booking";
$result = mysqli_query($con,$query);
$result || die("Database access failed: ".mysqli_error($con));

$finfo = mysqli_fetch_fields($result);

echo "<table border=¡¯1¡¯ cellpadding=¡¯5¡¯>\n";

echo "<tr>";
foreach($finfo as $val){
		echo "<td>", $val->name, "</td>";
}

	while($row = mysqli_fetch_array($result, MYSQLI_BOTH)){
		echo "<tr>";
		echo "<td>", $row[0], "</td>";
		echo  "<td>",$row[1], "</td>";
		echo  "<td>",$row[2],"</td>";
		echo  "<td>",$row[3],"</td>";
		echo "<tr>";
	}
echo "</tr>";
echo "</br>";
mysqli_free_result($result); // free memory
*/


//Query days that are available to book
$query = "select id, day from tutorial where capacity > 0 group by day";
$result2 = mysqli_query($con,$query);
$result2 || die("Database access failed: ".mysqli_error($con));

//First form : Dropdown menu for Day
echo<<<FORMSTART
<form name="form1" method="post" action="http://cgi.csc.liv.ac.uk/~u3mk/tutorials.php">
<select name="dropdown1" onChange="form1.submit()" style="width: 170px;">
<option value=0>Select a Day</option>
FORMSTART;
//populate dropdown with available days 
//value is the tutorial id, option is the day
while($row = mysqli_fetch_array($result2, MYSQLI_BOTH)){
	echo "<option ";
	if($_SESSION["day"] == $row['id'])
		echo "selected";
	echo " value=", $row['id'],">", $row['day'],"</option>";
}
echo<<<FORMEND
</select>
</form>
FORMEND;
mysqli_free_result($result2);

//Query timeslots that are available depending on the selected day
$query = "select id, time from tutorial where day = (select day from tutorial where id = ".$_SESSION["day"].") and capacity>0" ;
$result3 = mysqli_query($con,$query);
$result3 || die("Database access failed: ".mysqli_error($con));

//Second Form : Dropdown menu for timeslot
echo<<<FORMSTART
<form name="form2" method="post" action="http://cgi.csc.liv.ac.uk/~u3mk/tutorials.php">
<select name="dropdown2" onChange="form2.submit()" style="width: 170px;">
<option value=0>Select a Time slot</option>
FORMSTART;
//populate dropdown with available timeslots 
//value is the tutorial id, option is the timeslot
while($row = mysqli_fetch_array($result3, MYSQLI_BOTH)){
	echo "<option ";
	if($_SESSION["time"] == $row['id'])
		echo "selected";
	echo " value=", $row['id'],">", $row['time'],"</option>";
}
echo<<<FORMEND
</select>
</form>
FORMEND;
echo "</br>";
mysqli_free_result($result3);

//Third form : text fields for student info & questions
echo<<<FORM3PT1
<form name="form3" method="POST" action="http://cgi.csc.liv.ac.uk/~u3mk/tutorials.php">
Name: </br><input type="text" name="name" size="50" 
FORM3PT1;
if($failed)
echo "value = ", $_SESSION["getName"];

echo<<<FORM3PT2
/><br /></br>
Email: </br><input type="text" name="email" size="50"
FORM3PT2;
if($failed)
echo "value = ", $_SESSION["getEmail"];

echo<<<FORM3PT3
 /><br /></br>
Questions: </br><input type="text" name="questions" size="50" /><br /></br>
</br>
<input type="submit" name="book" value="Book"/>
</form>
FORM3PT3;

//close connection
mysqli_close($con);
?>
</body></html>
