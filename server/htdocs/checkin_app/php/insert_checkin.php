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

// Query to retrieve the latest check-in record for the employee
$sqlLatestCheckin = "SELECT * FROM `tbl_checkin` WHERE `employee_id` = '$employeeid' ORDER BY `checkin_date` DESC, `checkin_time` DESC LIMIT 1";
$resultLatestCheckin = $conn->query($sqlLatestCheckin);

if ($resultLatestCheckin->num_rows > 0) {
    $latestCheckinRow = $resultLatestCheckin->fetch_assoc();
    $latestCheckinTime = strtotime($latestCheckinRow['checkin_date'] . ' ' . $latestCheckinRow['checkin_time']);
    $currentCheckinTime = strtotime(date('Y-m-d') . ' ' . date('H:i:s'));

    // Calculate the time difference in seconds
    $timeDifference = $currentCheckinTime - $latestCheckinTime;
    $timeDifferenceInHours = $timeDifference / (60 * 60);

    if ($timeDifferenceInHours < 2) {
        // User has already checked in within the restriction period
        $response = array('status' => 'failed', 'data' => 'You have already checked in within the last two hours');
        sendJsonResponse($response);
        die();
    }
}

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
