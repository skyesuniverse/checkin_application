<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$employeeid = $_POST['employeeid'];
$sqlloadcheckin = "SELECT * FROM `tbl_checkin` WHERE employee_id = '$employeeid'";
$result = $conn->query($sqlloadcheckin);
if ($result->num_rows > 0) {
    $checkin["checkin"] = array();

    while ($row = $result->fetch_assoc()) {
        $checkinlist = array();
        $checkinlist['checkin_id'] = $row['checkin_id'];
        $checkinlist['employee_id'] = $row['employee_id'];
        $checkinlist['checkin_lat'] = $row['checkin_lat'];
        $checkinlist['checkin_long'] = $row['checkin_long'];
        $checkinlist['checkin_state'] = $row['checkin_state'];
        $checkinlist['checkin_locality'] = $row['checkin_locality'];
        $checkinlist['checkin_date'] = $row['checkin_date'];
        $checkinlist['checkin_time'] = $row['checkin_time'];
        array_push($checkin["checkin"], $checkinlist);
    }
    $response = array('status' => 'success', 'data' => $checkin);
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
