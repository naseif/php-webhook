<?php 
$servername = "serverName";
$username = "username";
$password = "password";

try {
  $conn = new PDO("mysql:host=$servername;dbname=databasename", $username, $password);
  // set the PDO error mode to exception
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//   echo "Connected successfully";
} catch(PDOException $e) {
//   echo "Connection failed: " . $e->getMessage();
}
$user =  $_REQUEST["user"];
$repo = $_REQUEST["repository"];

$stmt = $conn->prepare("SELECT * FROM LastPushForRepository WHERE username = :username AND repository = :repository");
$stmt->execute(['username' => $user, 'repository' => $repo]); 
$row = $stmt->fetch();
echo $row["LastPushDateTime"]
?> 