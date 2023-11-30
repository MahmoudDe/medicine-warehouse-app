<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MedicineController;

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

// Medicine Routes for public 
// Return All Medicines from Database 
Route::get('/medicines', [MedicineController::class, 'index']);

// Show By one (Medicine Card) 
Route::get('/medicines/{medicines}', [MedicineController::class, 'show']);
    
// Show By Categories (Filtering)
Route::get('/medicines/search/{category}', [MedicineController::class, 'search']);

// useres api 
// to register
// Route::post('/users/register', [AuthController::class, 'register']);
// to login 
// Route::post('/users/login', [AuthController::class, 'login']);
//to logout
// Route::post('/users/logout', [AuthController::class, 'logout']);






// protected for store user
// group what can store do 
Route::group((['middleware'=>['auth:sanctum']]),function(){

// To Create New Medicine :: Used By Admin  
Route::post('/medicines', [MedicineController::class, 'store']);

// To Edit Medicine :: Used By Admin
Route::put('/medicines/{medicine}', [MedicineController::class, 'update']);

// To Delete Medicine :: Used By Admin
Route::delete('/medicines/{medicine}', [MedicineController::class, 'destroy']);


});

// User Routes 
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {

    return $request->user();
});

// Order Routes
