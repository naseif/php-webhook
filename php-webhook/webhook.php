<?php

$postBody = $_POST['payload'];
$payload = json_decode($postBody);
$temp =  $payload->repository->full_name;
$split = explode("/", $temp);
if(count($split) === 2) {
    $servername = "servername";
    $username = "username";
    $password = "password";

    try {
        $conn = new PDO("mysql:host=$servername;dbname=database", $username, $password);

        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {

    }
    $user =  $split[0];
    $repo = $split[1];

    $stmt = $conn->prepare("CALL SavePush ( @Username := :username , @Repository := :repository )");
    $stmt->execute(['username' => $user, 'repository' => $repo]); 
}
?> 
