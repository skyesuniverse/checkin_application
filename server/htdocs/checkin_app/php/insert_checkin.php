<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$employeeid = $_POST['employeeid'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$state = $_POST['state'];
$locality = $_POST['locality'];
$sqlinsert = "INSERT INTO `tbl_checkin`(`employee_id`, `checkin_lat`, `checkin_long`, `checkin_state`, `checkin_locality`) VALUES ('$employeeid','$latitude','$longitude','$state','$locality')";

if ($conn->query($sqlinsert) === TRUE) {

    $response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
