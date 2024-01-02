<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MedicineController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\OrderItemController;
use App\Http\Controllers\ReportController;

require __DIR__ . '/auth.php';

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


/*Medicine Routes*/

// Medicine Routes for public 


// public  api 
// to register
Route::post('/users/register', [AuthController::class, 'register']);
// to login 
Route::post('/users/login', [AuthController::class, 'login']);



// Return All Medicines from Database 

Route::get('/medicines', [MedicineController::class, 'index']);

// Return All categories from Database 

Route::get('/categories', [CategoryController::class, 'index']);


/*User Routes*/
Route::group((['middleware' => ['auth:sanctum']]), function () {


    // Show By one (Medicine Card) 
    Route::get('/medicines/{medicines}', [MedicineController::class, 'show']);

    // Show By Categories (Filtering)
    Route::get('/medicines/search/{category}', [MedicineController::class, 'search']);

    // Logout user
    Route::post('/users/logout', [AuthController::class, 'logout']);
    // Create New Order :: User

    // Show All Orders
    Route::get('/orders', [OrderController::class, 'index']);

    //to logout
    Route::post('/users/logout', [AuthController::class, 'logout']);

    // Delete User Acount
    Route::delete('/users/delete', [AuthController::class, 'deleteUser']);
});

// protected for store user
// group what can admin  do 
Route::group((['prefix' => 'admin', 'middleware' => ['auth:sanctum']]), function () {

    // Show By one (Medicine Card) 
    Route::get('/medicines/{medicines}', [MedicineController::class, 'show']);

    // To Create New Medicine :: Used By Admin  
    Route::post('/medicines', [MedicineController::class, 'store']);

    // To Edit Medicine :: Used By Admin
    Route::put('/medicines/{medicine}', [MedicineController::class, 'update']);

    // To Delete Medicine :: Used By Admin
    Route::delete('/medicines/{medicine}', [MedicineController::class, 'destroy']);

    // Show By Categories (Filtering)
    Route::get('/medicines/search/{category}', [MedicineController::class, 'search']);

    // To Create New Category :: Used By Admin  
    Route::post('/categories', [CategoryController::class, 'store']);


});

Route::post('/orders', [OrderController::class, 'store']);


Route::get('/orders', [OrderController::class, 'index']);


/*Order Routes*/
Route::get('/orders/user/{userId}', [OrderController::class, 'indexForUser']);

// To Accept Order :: Admin
Route::post('orders/{order}/accept', [OrderController::class, 'acceptOrder']);

// To Reject Order :: Admin
Route::post('orders/{order}/reject', [OrderController::class, 'rejectOrder']);

// Show Order by order_id
Route::get('/orders/{order}', [OrderController::class, 'show']);

// Update order
Route::put('/orders/{order}', [OrderController::class, 'update']);

// Delete Order
Route::delete('/orders/{order}', [OrderController::class, 'destroy']);



/*OrderItem Routes*/

// Show All OrderItems
Route::get('/order_items', [OrderItemController::class, 'index']);

Route::post('/order_items', [OrderItemController::class, 'store']);

Route::get('/order_items/{order_item}', [OrderItemController::class, 'show']);

Route::put('/order_items/{orders_item}', [OrderItemController::class, 'update']);

Route::delete('order_items/{order_item}', [OrderItemController::class, 'destroy']);


// Get OrderItems By order_id
Route::get('/order_items/order/{order}', [OrderItemController::class, 'getOrder']);





// get report for money
Route::post('/total', [OrderItemController::class, 'total']);
// get report for total amount
 Route::post('/quantity', [OrderItemController::class, 'quantity']);
