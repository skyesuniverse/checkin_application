<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$name = $_POST['name'];
$dept = $_POST['dept'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$otp = rand(10000, 99999);

$sqlinsert = "INSERT INTO `tbl_employee`(`employee_email`, `employee_name`, `employee_department`, `employee_phone`, `employee_password`, `employee_otp`) VALUES ('$email','$name','$dept','$phone','$password','$otp')";

if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => $sqlinsert);
    sendJsonResponse($response);
} else {
    $response =  array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
