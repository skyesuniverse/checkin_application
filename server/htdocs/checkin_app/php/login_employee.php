<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

$email = $_POST['email'];
$pass = sha1($_POST['password']);

include_once("dbconnect.php");

$sqllogin = "SELECT * FROM `tbl_employee` WHERE employee_email = '$email' AND employee_password = '$pass'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $employeearray = array();
        $employeearray['id'] = $row['employee_id'];
        $employeearray['email'] = $row['employee_email'];
        $employeearray['name'] = $row['employee_name'];
        $employeearray['dept'] = $row['employee_department'];
        $employeearray['phone'] = $row['employee_phone'];
        $employeearray['password'] = $_POST['password'];
        $employeearray['otp'] = $row['employee_otp'];
        $employeearray['datereg'] = $row['employee_datereg'];
        $response = array('status' => 'success', 'data' => $employeearray);
        sendJsonResponse($response);
    }
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
