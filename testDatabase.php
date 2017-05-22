<html><head></head><body>
<?php
$db_hostname = "localhost";
$db_database = "test_database";
$db_username = "root";
$db_password = "bonjourmysql";
$con = mysqli_connect($db_hostname,$db_username,$db_password,$db_database);
if (!$con) die("Unable to connect to MySQL: ".mysqli_connect_error());

// Code for 4c here
if(isset($_POST["insert"])){
$getID = $_POST["id2"];
$getName = $_POST["name2"];
$getAge = $_POST["age2"];
echo "Id : ", $getID, "Name : " , $getName , "Age : ", $getAge ;
$stmt = mysqli_stmt_init($con);
$stmt = mysqli_prepare($con, "insert into people (id,name,age) values(?,?,?)");
	mysqli_stmt_bind_param($stmt, "isi", $getID, $getName, $getAge);
	$success = mysqli_stmt_execute($stmt);
	mysqli_stmt_close($stmt);
}

// Code for 5a here
$query = "select * from people";
$result = mysqli_query($con,$query);
$result || die("Database access failed: ".mysqli_error($con));
//$rows = mysqli_num_rows($result);
//echo "Rows retrieved: $rows<br /><br />\n";

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
		echo "<tr>";
	}
echo "</tr>";
mysqli_free_result($result); // free memory
$query = "select * from people";
$result2 = mysqli_query($con,$query);
echo<<<FORMSTART
<form name="form1" method="post"
action="testDatabase.php">
<select name="select" onChange="form1.submit()">
<option value="None">Select a namex</option>
FORMSTART;

while($row = mysqli_fetch_array($result2, MYSQLI_BOTH)){
	echo "<option value=", $row[2],">", $row[1],"
</option>";
}



// Add further options here
echo<<<FORMEND
</select>
</form>
FORMEND;
//foreach ($_REQUEST as $key => $value)
//echo "$key => $value<br />\n";



echo<<<FORM2
<form name="form2" method="POST" action="testDatabase.php">
Id: <input type="text" name="id2" size="3" /><br />
Name: <input type="text" name="name2" size="100" /><br />
Age: <input type="text" name="age2" size="100" /><br />
<input type="submit" name="insert" value="Insert into DB" />
<input type="submit" name="query" value="Query DB" />
</form>
FORM2;


mysqli_close($con);
?>
</body></html>